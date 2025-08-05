import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/app_loading.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/profile/cubit/profile_cubit.dart';
import 'package:sms_owner/presentation/profile/model/user_model.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_appBar.dart';
import '../../../core/components/custom_textField.dart';

part '../widgets/field_widget.dart';

part '../widgets/info_card.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = context.read<ProfileCubit>();
    _profileCubit.fetchUpdateProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.success || state.status == ProfileStatus.savedSuccess) {
            _nameController.text = state.updateProfile?.user?.name ?? '';
            _usernameController.text = state.updateProfile?.user?.username ?? '';
            _emailController.text = state.updateProfile?.user?.email ?? '';
            _oldPasswordController.clear();
            _newPasswordController.clear();
          }
          if(state.status == ProfileStatus.savedSuccess){
            showSnackMessage(context, 'Profile updated successfully');
          }

          else if (state.status == ProfileStatus.error) {
            showSnackErrorMessage(context, state.error, 4);
          }
        },
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text('Account Settings', style: context.text14Medium)),
                    const SizedBox(height: 20),

                    Wrap(
                      runAlignment: WrapAlignment.start,
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _InfoCard(label: 'CURRENT BALANCE', value: '\$ ${state.updateProfile?.user?.balance ?? ''}'),
                        _InfoCard(label: 'SPEND BALANCE', value: '\$ ${state.updateProfile?.user?.spend ?? ''}'),

                        _InfoCard(label: 'LATEST ORDER', value: '${state.updateProfile?.latestOrder?.id ?? ''}'),
                        _InfoCard(label: 'LATEST TICKET', value: '${state.updateProfile?.latestTicket?.id ?? ''}'),
                      ],
                    ),
                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: _FieldWidget(
                            controller: _nameController,
                            label: 'Name',
                            hint: 'Enter name',
                            isPassword: false,
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),

                        const SizedBox(width: 16),
                        Expanded(
                          child: _FieldWidget(
                            controller: _usernameController,
                            label: 'Username',
                            hint: 'Enter username',
                            isPassword: false,
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _FieldWidget(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'Enter email',
                      isPassword: false,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 30),

                    // Password Change Section
                    Center(
                      child: const Text(
                        'CHANGE PASSWORD',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54, decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _FieldWidget(
                      controller: _oldPasswordController,
                      label: 'Old Password',
                      hint: 'Enter password to confirm',
                      isPassword: true,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),

                    _FieldWidget(
                      controller: _newPasswordController,
                      label: 'New Password (optional)',
                      hint: 'Enter new password to change',
                      isPassword: true,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 40),

                    Center(
                      child: CustomButton(
                        buttonTitle: 'Submit',
                        onPressed: () async {
                          Map<String, dynamic> body = {
                            "user_id": await SecureStorageService.getString(CommonKeys.userId),
                            "name": _nameController.text,
                            "username": _usernameController.text,
                            "email": _emailController.text,
                            "old_password": _oldPasswordController.text,
                          };
                          if (_newPasswordController.text.isNotEmpty) {
                            if(_newPasswordController.text.length<6){
                              showSnackErrorMessage(context, 'New password must be at least 6 characters', 3);
                              return;
                            }
                            body.addAll({"new_password": _newPasswordController.text});
                          }
                          _profileCubit.updateUserProfile(body);
                        },
                        height: 40,
                        disable: isDisabled(state.updateProfile?.user),
                        buttonColor: Colors.orange,
                        width: 126,
                        borderRadius: 10,
                        textStyle: context.text14Medium?.copyWith(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.status == ProfileStatus.saveLoading) Center(child: AppLoadingWidget()),
            ],
          );
        },
      ),
    );
  }

  bool isDisabled(UserModel? user) {
    if (_oldPasswordController.text.isEmpty || _oldPasswordController.text.length<6) {
      return true;
    }
    if (_nameController.text.isNotEmpty && (_nameController.text != user?.name)) {
      return false;
    }
    if (_usernameController.text.isNotEmpty && (_usernameController.text != user?.username)) {
      return false;
    }
    if (_emailController.text.isNotEmpty && (_emailController.text != user?.email)) {
      return false;
    }
    if(_newPasswordController.text.isNotEmpty){
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
