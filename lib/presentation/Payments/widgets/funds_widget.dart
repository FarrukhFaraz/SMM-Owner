import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/core/utils/api_url.dart';
import 'package:sms_owner/presentation/Payments/cubit/add_fund/add_fund_cubit.dart';
import 'package:sms_owner/presentation/Payments/cubit/payment_history/payment_history_cubit.dart';
import 'package:sms_owner/presentation/Payments/cubit/payment_method/payment_method_cubit.dart';

class FundsWidget extends StatefulWidget {
  const FundsWidget({super.key});

  @override
  State<FundsWidget> createState() => _FundsWidgetState();
}

class _FundsWidgetState extends State<FundsWidget> {
  TextEditingController amountController = TextEditingController();
  int? selectedMethod;
  bool terms = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, paymentConfiguration) {
        final config = paymentConfiguration.paymentConfig;
        final _ = paymentConfiguration.homeConfig;
        return Container(
          color: config.formBackgroundColor,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
              listener: (context, state) {
                if (state.status == PaymentMethodStatus.error) {
                  showSnackErrorMessage(context, state.error, 4);
                }
              },
              builder: (context, state) {
                if (state.status == PaymentMethodStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.status != PaymentMethodStatus.initial &&
                    state.paymentList.isEmpty) {
                  return Center(child: Text("No Payment Method"));
                }
                return Column(
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runSpacing: 20,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      spacing: 20,
                      children:
                          state.paymentList.map((e) {
                            if (e.logo == null) return SizedBox();
                            return Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  
                                  image: NetworkImage(
                                    '${APIURL.baseMediaUrl}/${e.logo}',
                                    scale: 1
                                  ),
                                  fit: BoxFit.contain,
                                  
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: selectedMethod,
                      hint: Text(
                        'Select Payment Method',
                        style: context.text15Light?.copyWith(
                          color: config.inputTextColor,
                        ),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: config.inputFieldColor,
                        border: OutlineInputBorder(),
                      ),
                      iconEnabledColor: Colors.black,
                      dropdownColor: Colors.white,
                      items:
                          state.paymentList
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name ?? '',
                                    style: TextStyle(
                                      color: config.inputTextColor,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        selectedMethod = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: amountController,
                      hintText: "Enter Amount",
                      inputTextStyle: context.text14Medium?.copyWith(
                        color: config.inputTextColor,
                      ),
                      fillColor: config.inputFieldColor,
                      border: OutlineInputBorder(),
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: terms,
                          onChanged: (val) {
                            terms = val ?? false;
                            setState(() {});
                          },
                          activeColor: config.checkboxColor,
                        ),
                        Text(
                          "I agree",
                          style: context.text12Bold?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: BlocConsumer<AddFundCubit, AddFundState>(
                            listener: (context, state) {
                              if (state.status == AddFundStatus.success) {
                                context
                                    .read<PaymentHistoryCubit>()
                                    .loadPaymentHistory();
                                showSnackMessage(
                                  context,
                                  "Payment successfully added",
                                );
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                onPressed: () {
                                  if (selectedMethod == null) {
                                    showSnackErrorMessage(
                                      context,
                                      "Please select payment methods",
                                      3,
                                    );
                                    return;
                                  }
                                  if (amountController.text.isEmpty ||
                                      amountController.text == '0') {
                                    showSnackErrorMessage(
                                      context,
                                      "Please enter amount",
                                      3,
                                    );
                                    return;
                                  }

                                  if (terms == false) {
                                    showSnackErrorMessage(
                                      context,
                                      "Please except terms and conditions",
                                      3,
                                    );
                                    return;
                                  }
                                  double amount =
                                      double.tryParse(amountController.text) ??
                                      0;
                                  context.read<AddFundCubit>().addFund(
                                    paymentId: selectedMethod ?? 0,
                                    amount: amount,
                                  );
                                },
                                buttonTitle: "Submit",
                                textStyle: context.smallCaption14500?.copyWith(
                                  color: config.submitTextColor,
                                ),
                                buttonColor: config.submitButtonColor,
                                loading: state.status == AddFundStatus.loading,
                                hasImage: false,
                                borderRadius: 30,
                              );
                            },
                          )
                          .animate()
                          .fade(duration: 500.ms)
                          .slideY(begin: 0.5, end: 0),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
