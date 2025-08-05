import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/app_loading.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/api_url.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/ticket/cubit/create_ticket/create_ticket_cubit.dart';
import 'package:sms_owner/presentation/ticket/cubit/ticket_history/ticket_history_cubit.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_appBar.dart';
import '../../../core/components/custom_textField.dart';
import '../../order/model/order_model.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key, this.selectedOrderId});
  final String? selectedOrderId;

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _requestController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  late CreateTicketCubit _createTicketCubit;
  String? selectedOrderId;

  @override
  void initState() {
    super.initState();
    selectedOrderId = widget.selectedOrderId;
    _createTicketCubit = context.read<CreateTicketCubit>();
    _createTicketCubit.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: BlocConsumer<CreateTicketCubit, CreateTicketState>(
        listener: (context, state) {
          if (state.status == CreateTicketStatus.saveSuccess) {
            showSnackMessage(context, 'Ticket created successfully');
            context.read<TicketHistoryCubit>().getTickets();
            Navigator.pop(context);
          }else if(state.status == CreateTicketStatus.error){
            showSnackErrorMessage(context, state.error, 3);
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text('Create New Ticket', style: context.text14Medium)),
                    const SizedBox(height: 20),

                    // Subject Field
                    _buildInputField(label: 'Subject', controller: _subjectController, isRequired: true),
                    const SizedBox(height: 20),

                    // Order Field
                    // _buildInputField(
                    //   label: 'Order',
                    //   controller: _orderController,
                    //   isRequired: true,
                    // ),
                    _buildDropdownField(
                      label: "Order",
                      selectedValue: selectedOrderId,
                      orders: state.orderList,
                      isRequired: true,
                      onChanged: (value) {
                        setState(() {
                          selectedOrderId = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // Email Field
                    _buildInputField(label: 'Email', controller: _emailController, isRequired: true),
                    const SizedBox(height: 20),

                    // Request Field
                    _buildInputField(label: 'Request', controller: _requestController, isRequired: true),
                    const SizedBox(height: 20),

                    // Message Field
                    _buildInputField(label: 'Message', controller: _messageController, isRequired: true, maxLines: 6),
                    const SizedBox(height: 40),

                    Center(
                      child: CustomButton(
                        buttonTitle: 'Submit',
                        onPressed: () {
                          _handleSubmit();
                        },
                        height: 36,
                        buttonColor: Color(0xffffde59),
                        width: 122,
                        borderRadius: 10,
                        textStyle: context.text12Medium?.copyWith(color: Color(0xff372a28), fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.status == CreateTicketStatus.saveLoading) SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: AppLoadingWidget()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputField({required String label, required TextEditingController controller, bool isRequired = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff372a28)),
            children: [TextSpan(text: label), if (isRequired) const TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
          ),
        ),
        const SizedBox(height: 8),

        CustomTextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: TextInputType.text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 0.6, color: CupertinoColors.systemGrey)),
          hintText: '',
          hintStyle: context.text12Regular?.copyWith(fontSize: 10),
          isDense: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          inputTextStyle: context.text12Regular?.copyWith(fontSize: 12),
          onChanged: (val) {},
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? selectedValue,
    required List<OrderModel> orders,
    required void Function(String?) onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff372a28)),
            children: [TextSpan(text: label), if (isRequired) const TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.6, color: CupertinoColors.systemGrey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              icon: const SizedBox.shrink(),
              // Remove dropdown icon
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              style: context.text12Regular?.copyWith(fontSize: 12, color: Colors.black),
              hint: Text('Select an order', style: context.text12Regular?.copyWith(fontSize: 10)),
              items:
                  orders.map((order) {
                    return DropdownMenuItem<String>(value: order.id?.toString(), child: Text(order.service?.name ?? ''));
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    // Validate fields
    if (_subjectController.text.isEmpty ||
        selectedOrderId == null ||
        _emailController.text.isEmpty ||
        _requestController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all required fields'), backgroundColor: Colors.red));
      return;
    }

    String? userId = await SecureStorageService.getString(CommonKeys.userId);

    Map<String, dynamic> body = {
      "category": "category",
      "subcategory": "refill",
      "order_id": int.tryParse(selectedOrderId??''),
      "user_id": int.tryParse(userId??''),
      "domain_id": 1,
      "domain": APIURL.baseMediaUrl,
      "subject": _subjectController.text,
      "email": _emailController.text,
      "request": _requestController.text,
      "message": _messageController.text,
      "attachments": [],
    };

    print('_CreateTicketScreenState._handleSubmit:::: $body');

    _createTicketCubit.createTicket(body);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _emailController.dispose();
    _requestController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
