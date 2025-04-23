import 'package:flutter/material.dart';

class PaymentConfig {
  final Color tabBarBackgroundColor;
  final Color activeTabColor;
  final Color inactiveTabColor;
  final Color formBackgroundColor;
  final Color inputFieldColor;
  final Color inputTextColor;
  final Color dropdownColor;
  final Color checkboxColor;
  final Color submitButtonColor;
  final Color submitTextColor;
  final Color historyCardColor;
  final Color methodTextColor;
  final Color amountTextColor;
  final Color dateTextColor;
  final Color statusTextColor;

  PaymentConfig({
    required this.tabBarBackgroundColor,
    required this.activeTabColor,
    required this.inactiveTabColor,
    required this.formBackgroundColor,
    required this.inputFieldColor,
    required this.inputTextColor,
    required this.dropdownColor,
    required this.checkboxColor,
    required this.submitButtonColor,
    required this.submitTextColor,
    required this.historyCardColor,
    required this.methodTextColor,
    required this.amountTextColor,
    required this.dateTextColor,
    required this.statusTextColor,
  });

  factory PaymentConfig.fromMap(Map<String, dynamic> map) {
    Color hex(String? hex) =>
        Color(int.parse('FF${hex?.replaceAll('#', '')}', radix: 16));

    return PaymentConfig(
      tabBarBackgroundColor: hex(map["tabBarBackgroundColor"]),
      activeTabColor: hex(map["activeTabColor"]),
      inactiveTabColor: hex(map["inactiveTabColor"]),
      formBackgroundColor: hex(map["formBackgroundColor"]),
      inputFieldColor: hex(map["inputFieldColor"]),
      inputTextColor: hex(map["inputTextColor"]),
      dropdownColor: hex(map["dropdownColor"]),
      checkboxColor: hex(map["checkboxColor"]),
      submitButtonColor: hex(map["submitButtonColor"]),
      submitTextColor: hex(map["submitTextColor"]),
      historyCardColor: hex(map["historyCardColor"]),
      methodTextColor: hex(map["methodTextColor"]),
      amountTextColor: hex(map["amountTextColor"]),
      dateTextColor: hex(map["dateTextColor"]),
      statusTextColor: hex(map["statusTextColor"]),
    );
  }
}
