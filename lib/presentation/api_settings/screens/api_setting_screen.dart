import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/app_loading.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/presentation/api_settings/cubit/api_settings_cubit.dart';
import 'package:sms_owner/presentation/api_settings/model/api_setting_model.dart';

class ApiSettingScreen extends StatefulWidget {
  const ApiSettingScreen({super.key});

  @override
  State<ApiSettingScreen> createState() => _ApiSettingScreenState();
}

class _ApiSettingScreenState extends State<ApiSettingScreen> {
  late ApiSettingsCubit _apiSettingsCubit;

  @override
  void initState() {
    super.initState();
    _apiSettingsCubit = context.read<ApiSettingsCubit>();
    _apiSettingsCubit.fetchAPISettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: BlocBuilder<ApiSettingsCubit, ApiSettingsState>(
        builder: (context, state) {
          if (state.status == APISettingsStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.status != APISettingsStatus.initial && state.apiSettingList.isEmpty) {
            return Center(child: Text('No data found'));
          }
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('API', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    shrinkWrap: true,
                    itemCount: state.apiSettingList.length,
                    itemBuilder: (context, index) {
                      ApiSettingModel model = state.apiSettingList[index];

                      return Container(
                        margin: EdgeInsets.only(
                            top: index == 0 ? 0 : 20
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(16)
                        ),
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                CustomButton(
                                  buttonTitle: 'Change APi Key',
                                  onPressed: () {
                                  },
                                  height: 36,
                                  buttonColor: Color(0xffffc61a),
                                  width: 116,
                                  borderRadius: 10,
                                  textStyle: context.text12Medium?.copyWith(color: Colors.white, fontSize: 11),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(top: BorderSide(width: 1, color: Colors.grey)),
                              ),
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  _buildApiRow(context: context, title: 'HTTP Method', value: model.httpMethod??''),
                                  Container(height: 1, width: double.infinity, color: Colors.grey),
                                  _buildApiRow(context: context, title: 'API URL', value: model.apiUrl??'', shouldCopy: true),
                                  Container(height: 1, width: double.infinity, color: Colors.grey),
                                  _buildApiRow(context: context, title: 'API Key', value: model.apiKey??'', shouldCopy: true),
                                  Container(height: 1, width: double.infinity, color: Colors.grey),
                                  _buildApiRow(context: context, title: 'Response format', value: model.responseFormat??''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              if(state.status == APISettingsStatus.saveLoading)
                Center(child: AppLoadingWidget()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildApiRow({required BuildContext context, required String title, required String value, bool shouldCopy = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text("$title:", style: context.text13Bold)),
          Container(height: 40, width: 1, color: Colors.grey),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                SizedBox(width: 12),
                Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
                if (shouldCopy) ...[
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      await FlutterClipboard.copy(value);
                      showSnackMessage(context, 'Text copied');
                    },
                    child: Icon(Icons.copy, color: Colors.black54, size: 20),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
