import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/presentation/Payments/cubit/payment_history/payment_history_cubit.dart';
import 'package:sms_owner/presentation/Payments/model/payment_history_model.dart';

class FundsHistory extends StatefulWidget {
  const FundsHistory({super.key});

  @override
  State<FundsHistory> createState() => _FundsHistoryState();
}

class _FundsHistoryState extends State<FundsHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, paymentConfiguration) {
        final config = paymentConfiguration.paymentConfig;
        final _ = paymentConfiguration.homeConfig;
        return Container(
          decoration: BoxDecoration(color: config.firstContainerColor),
          child: BlocConsumer<PaymentHistoryCubit, PaymentHistoryState>(
            listener: (context, state) {
              if (state.status == PaymentHistoryStatus.error) {
                showSnackErrorMessage(context, state.error, 4);
              }
            },
            builder: (context, state) {
              if (state.status == PaymentHistoryStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.status != PaymentHistoryStatus.initial && state.paymentHistory.isEmpty) {
                return Center(child: Text("No payment history found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(left: 12, top: 2, right: 12, bottom: 10),
                itemCount: state.paymentHistory.length,
                itemBuilder: (context, index) {
                  PaymentHistoryModel model = state.paymentHistory[index];
                  return Card(
                    color: config.historyCardColor,
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),

                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet),
                      title: Text(model.paymentMethod ?? '', style: TextStyle(color: config.methodTextColor)),
                      subtitle: Text(
                        '${DateFormat('yyyy-MM-dd').tryParse(model.createdAt ?? '') ?? ''}',
                        style: TextStyle(color: config.dateTextColor),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("\$${model.amount}", style: TextStyle(color: config.amountTextColor)),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: config.paymentStatusColor, borderRadius: BorderRadius.circular(8)),
                            child: Text("Success", style: TextStyle(fontSize: 12, color: config.statusTextColor)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
