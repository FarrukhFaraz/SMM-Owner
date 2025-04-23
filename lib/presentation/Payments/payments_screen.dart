import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> paymentMethods = [
    "JazzCash Manual Payment",
    "Easypaisa Manual Payment",
  ];
  String selectedMethod = "JazzCash Manual Payment";

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
                decoration: BoxDecoration(color: Colors.white),
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
                  children: [
                    // Add Funds Form
                    Container(
                      color: config.formBackgroundColor,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedMethod,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: config.inputFieldColor,
                              border: OutlineInputBorder(),
                            ),
                            items:
                                paymentMethods
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: config.inputTextColor,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() => selectedMethod = value ?? "");
                            },
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Amount",
                              filled: true,
                              fillColor: config.inputFieldColor,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (_) {},
                                activeColor: config.checkboxColor,
                              ),
                              const Text("I agree"),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: config.submitButtonColor,
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: config.submitTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Funds History
                    ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: 5,
                      itemBuilder:
                          (_, i) => Card(
                            color: config.historyCardColor,
                            child: ListTile(
                              leading: const Icon(Icons.account_balance_wallet),
                              title: Text(
                                paymentMethods[0],
                                style: TextStyle(color: config.methodTextColor),
                              ),
                              subtitle: Text(
                                "2025-04-21",
                                style: TextStyle(color: config.dateTextColor),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "\$3200",
                                    style: TextStyle(
                                      color: config.amountTextColor,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Success",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: config.statusTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
