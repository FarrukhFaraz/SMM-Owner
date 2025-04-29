import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';
import 'package:sms_owner/presentation/Payments/cubit/payment_history/payment_history_cubit.dart';
import 'package:sms_owner/presentation/Payments/cubit/payment_method/payment_method_cubit.dart';
import 'package:sms_owner/presentation/Payments/widgets/funds_history.dart';
import 'package:sms_owner/presentation/Payments/widgets/funds_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
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
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(color: config.tabBarBackgroundColor),
                child: customAppBar(homeConfig),
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: config.paymentContainerColor),
                child: Center(
                  child: Text(
                    "Payments",
                    style: context.text16Light?.copyWith(color: Colors.black),
                  ),
                ),
              ),
              Container(
                color: config.tabBarBackgroundColor,
                child: TabBar(
                  controller: _tabController,
                  labelColor: config.activeTabColor,
                  indicatorColor: config.tabBarIndicatorColor,
                  unselectedLabelColor: config.inactiveTabColor,
                  tabs: const [
                    Tab(text: "Add Funds"),
                    Tab(text: "Funds History"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [const FundsWidget(), const FundsHistory()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
