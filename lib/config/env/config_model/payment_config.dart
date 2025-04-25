import 'package:flutter/material.dart';

class PaymentConfig {
  //add Fund 
  final Color tabBarBackgroundColor;
  final Color activeTabColor;
  final Color inactiveTabColor;
  final Color formBackgroundColor;
  final Color inputFieldColor;
  final Color inputTextColor;
  final Color dropdownColor;
  final Color checkboxColor;
  final Color dropDownIconColor;
  final Color tabBarIndicatorColor;
  final Color submitButtonColor;
  final Color paymentContainerColor;
  final Color submitTextColor;
  final Color historyCardColor;
  final Color methodTextColor;
  final Color amountTextColor;
  final Color dateTextColor;
  final Color statusTextColor;

// Funds History

  final Color firstContainerColor;
  final Color paymentStatusColor;

  PaymentConfig({
  // Add Fund
    required this.tabBarBackgroundColor,
    required this.activeTabColor,
    required this.inactiveTabColor,
    required this.formBackgroundColor,
    required this.paymentContainerColor,
    required this.inputFieldColor,
    required this.inputTextColor,
    required this.dropdownColor,
    required this.checkboxColor,
    required this.dropDownIconColor,
    required this.tabBarIndicatorColor,
    required this.submitButtonColor,
    required this.submitTextColor,
    required this.historyCardColor,
    required this.methodTextColor,
    required this.amountTextColor,
    required this.dateTextColor,
    required this.statusTextColor,

  //
    required this.firstContainerColor,
    required this.paymentStatusColor,  
  });

  factory PaymentConfig.fromMap(Map<String, dynamic> map) {
    Color hex(String? hex) =>
        Color(int.parse('FF${hex?.replaceAll('#', '')}', radix: 16));

    return PaymentConfig(
      //Add Fund
      tabBarBackgroundColor: hex(map["tabBarBackgroundColor"]),
      activeTabColor: hex(map["activeTabColor"]),
      inactiveTabColor: hex(map["inactiveTabColor"]),
      formBackgroundColor: hex(map["formBackgroundColor"]),
      paymentContainerColor: hex(map['paymentContainerColor']),
      inputFieldColor: hex(map["inputFieldColor"]),
      inputTextColor: hex(map["inputTextColor"]),
      dropdownColor: hex(map["dropdownColor"]),
      dropDownIconColor: hex(map['dropDownIconColor']),
      tabBarIndicatorColor: hex(map['tabBarIndicatorColor']),
      checkboxColor: hex(map["checkboxColor"]),
      submitButtonColor: hex(map["submitButtonColor"]),
      submitTextColor: hex(map["submitTextColor"]),
      historyCardColor: hex(map["historyCardColor"]),
      methodTextColor: hex(map["methodTextColor"]),
      amountTextColor: hex(map["amountTextColor"]),
      dateTextColor: hex(map["dateTextColor"]),
      statusTextColor: hex(map["statusTextColor"]),
      //Fund History
      firstContainerColor: hex(map['firstContainerColor']),
      paymentStatusColor: hex(map['paymentStatusColor'])
    );
  }
}
