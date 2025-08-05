import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/show_dialog_loading.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/ticket/cubit/ticket_message/ticket_message_cubit.dart';
import 'package:sms_owner/presentation/ticket/model/ticket_message_model.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_appBar.dart';
import '../model/ticket_history_model.dart';

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({super.key, required this.model});

  final TicketHistoryModel model;

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  TextEditingController messageController = TextEditingController();

  late TicketMessageCubit _ticketMessageCubit;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _node = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ticketMessageCubit = context.read<TicketMessageCubit>();
    _ticketMessageCubit.getTicketMessages(widget.model.id?.toString() ?? '');
  }

  void _scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_node.hasFocus) {
        _node.requestFocus();
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTicketHeader(),
                  const SizedBox(height: 16),
                  _buildRequestId(),
                  const SizedBox(height: 16),
                  _buildMessagesSection(),
                ],
              ),
            ),
          ),
          _buildMessageInputBox(),
        ],
      ),
    );
  }

  Widget _buildTicketHeader() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildInfoCard(label: 'TICKET ID', value: widget.model.id?.toString() ?? ''),
        _buildInfoCard(label: 'SUBJECT', value: widget.model.subject ?? '', valueColor: Colors.green),
        _buildInfoCard(label: 'REQUEST', value: widget.model.request ?? '', valueColor: Colors.green),
        _buildInfoCard(label: 'TICKETS STATUS', value: widget.model.order?.status ?? '', valueColor: Color(0xff7d7d7d)),
      ],
    );
  }

  Widget _buildInfoCard({required String label, String? value, Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: context.text10Bold?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(value ?? '', style: context.text10Bold?.copyWith(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _buildRequestId() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Request ID#", style: context.text10Bold?.copyWith(fontWeight: FontWeight.w500)),
          SizedBox(height: 6),
          Text(widget.model.order?.id?.toString() ?? '', style: context.text10Bold?.copyWith(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _buildMessagesSection() {
    return BlocConsumer<TicketMessageCubit, TicketMessageState>(
      listener: (context, state) {
        if (state.status == TicketMessageStatus.sent) {
          // Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state.status == TicketMessageStatus.loading) {
          return Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MESSAGE", style: context.text10Bold?.copyWith(fontWeight: FontWeight.w400)),
            const SizedBox(height: 12),
            if(state.messageList.isNotEmpty)...[
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                child: Column(children: state.messageList.map((msg) => _buildMessageBubble(msg)).toList()),
              )
            ]
            else
              ...[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Center(child: Text('No message')),
                ),
              ]
            ,
          ],
        );
      },
    );
  }

  Widget _buildMessageBubble(TicketMessageModel msg) {
    return Align(
      alignment: (msg.isMe ?? false) ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: (msg.isMe ?? false) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if ((msg.isMe ?? false) ) ...[
                  CircleAvatar(radius: 12, child: Icon(Icons.person, size: 14)),
                  SizedBox(width: 6),
                  Text(msg.user?.name ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ] else
                  ...[
                    Text("SUPPORT TEAM", style: TextStyle(fontSize: 14, letterSpacing: 0.5)),
                    SizedBox(width: 4),
                    Icon(Icons.person, size: 16),
                  ],
              ],
            ),
            SizedBox(height: 4),
            Container(
              constraints: BoxConstraints(maxWidth: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(msg.message ?? '',
                style: context.text14Regular,
              ),
            ),
            SizedBox(height: 4),
            Text(getTime(msg.updatedAt), style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          ],
        ),
      ),
    );
  }

  String getTime(DateTime? date) {
    if (date == null) {
      return '';
    }
    return DateFormat('dd MMM yyyy hh:mm a').format(date);
  }

  Widget _buildMessageInputBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              minLines: 1,
              onChanged: (val) {
                if (val.length < 2) {
                  setState(() {});
                }
              },
              maxLines: 5,
              decoration: InputDecoration(hintText: "Type a message here....", border: InputBorder.none),
            ),
          ),

          CustomButton(
            onPressed: () async{
              // showDialogLoading(context, 'sending');
              Map<String, dynamic> body = {
                "ticket_id": widget.model.id.toString(),
                "user_id": await SecureStorageService.getString(CommonKeys.userId),
                "message": messageController.text,
                "is_me": true,
                "attachments": []
              };
              messageController.clear();
              await _ticketMessageCubit.sendTicketMessages(body);
              _scrollToBottom();
            },
            buttonTitle: 'Send',
            buttonColor: Colors.green,
            borderRadius: 50,
            textStyle: context.text14Medium?.copyWith(color: Colors.white),
            height: 40,
            disable: messageController.text.isEmpty,
            width: 70,
          ),
        ],
      ),
    );
  }
}
