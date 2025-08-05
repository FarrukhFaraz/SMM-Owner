import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';
import 'package:sms_owner/presentation/payments/cubit/payment_history/payment_history_cubit.dart';
import 'package:sms_owner/presentation/payments/cubit/payment_method/payment_method_cubit.dart';
import 'package:sms_owner/presentation/payments/widgets/funds_history.dart';
import 'package:sms_owner/presentation/payments/widgets/funds_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    context.read<PaymentMethodCubit>().loadPaymentMethod();
    context.read<PaymentHistoryCubit>().loadPaymentHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, paymentConfiguration) {
        final config = paymentConfiguration.paymentConfig;
        final homeConfig = paymentConfiguration.homeConfig;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: customAppBar2(
              backgroundColor: Color(0xff00695c)
          ),
          body: Column(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: config.paymentContainerColor),
                child: Center(child: Text("payments", style: context.text16Bold?.copyWith(color: Colors.black, fontStyle: FontStyle.italic))),
              ),
              Container(
                color: config.tabBarBackgroundColor,
                child: TabBar(
                  controller: _tabController,
                  labelColor: config.activeTabColor,
                  indicatorColor: config.tabBarIndicatorColor,
                  unselectedLabelColor: config.inactiveTabColor,
                  tabs: const [Tab(text: "Add Funds"), Tab(text: "Funds History")],
                ),
              ),
              Expanded(child: TabBarView(controller: _tabController, children: [const FundsWidget(), const FundsHistory()])),
            ],
          ),
        );
      },
    );
  }
}
