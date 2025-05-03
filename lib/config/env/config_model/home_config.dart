import 'package:flutter/material.dart';

class HomeConfig {
  // colors
  final Color backContainerColor;
  final Color frontContainerColor;
  final Color backGroundColor;
  final Color menuIconColor;
  final Color logoTextColor;

  // wallet
  final Color walletContainerColor;
  final Color walletIconColor;
  final Color walletinfoTitleColor;
  final Color walletInfoValueColor;

  // textField
  final Color textFieldColor;
  final Color textFieldBorderColor;
  final Color hintTextColor;
  final Color serviceIdTagColor;
  final Color serviceIdTextColor;
  final Color categoryTextColor;

  // search
  final Color searchButtonBackgroundColor;
  final Color searchButtonIconColor;

  // dropDown
  final Color dropdownBorderColor;
  final Color dropDownColor;
  final Color dropDownTextColor;
  final Color dropDownFieldColor;

  // All other Colors
  final Color pasteButtonBackgroundColor;
  final Color pasteButtonTextColor;
  final Color totalAmountColor;
  final Color orderButtonBackgroundColor;
  final Color orderButtonTextColor;
  final Color notificationIconColor;

  //

  HomeConfig({
    required this.backContainerColor,
    required this.frontContainerColor,
    required this.walletContainerColor,
    required this.walletIconColor,
    required this.walletinfoTitleColor,
    required this.walletInfoValueColor,
    required this.backGroundColor,
    required this.menuIconColor,
    required this.logoTextColor,
    required this.textFieldColor,
    required this.hintTextColor,
    required this.searchButtonBackgroundColor,
    required this.searchButtonIconColor,
    required this.dropdownBorderColor,
    required this.dropDownTextColor,
    required this.dropDownColor,
    required this.dropDownFieldColor,
    required this.serviceIdTagColor,
    required this.serviceIdTextColor,
    required this.textFieldBorderColor,
    required this.pasteButtonBackgroundColor,
    required this.pasteButtonTextColor,
    required this.totalAmountColor,
    required this.orderButtonBackgroundColor,
    required this.orderButtonTextColor,
    required this.notificationIconColor,
    required this.categoryTextColor,
  });

  factory HomeConfig.fromMap(Map<String, dynamic> map) {
    return HomeConfig(
      backContainerColor: _hexToColor(map['backContainerColor'] ?? '#00bf63'),
      frontContainerColor: _hexToColor(map['frontContainerColor'] ?? '#00695c'),
      walletContainerColor: _hexToColor(map['walletContainerColor'] ?? '#372a28'),
      walletIconColor: _hexToColor(map['walletIconColor'] ?? '#ffc61a'),
      walletinfoTitleColor: _hexToColor(map['walletinfoTitleColor'] ?? '#fff4ea'),
      walletInfoValueColor: _hexToColor(map['walletInfoValueColor'] ?? '#fff4ea'),
      backGroundColor: _hexToColor(map['backGroundColor'] ?? '#fff4ea'),
      menuIconColor: _hexToColor(map['menuIconColor'] ?? '#fff4ea'),
      logoTextColor: _hexToColor(map['logoTextColor'] ?? '#ebc428'),
      textFieldColor: _hexToColor(map['textFieldColor'] ?? '#ebebeb'),
      hintTextColor: _hexToColor(map['hintTextColor'] ?? '#acb8c0'),
      searchButtonBackgroundColor: _hexToColor(
        map['searchButtonBackgroundColor'] ?? '#2b524a',
      ),
      searchButtonIconColor: _hexToColor(map['searchButtonIconColor'] ??'#000000'),
      dropDownColor: _hexToColor(map['dropDownColor']?? '#ffffff'),
      dropDownTextColor: _hexToColor(map['dropDownTextColor']?? '#000000'),
      dropDownFieldColor: _hexToColor(map['dropDownFieldColor'] ?? '#ebebeb'),
      dropdownBorderColor: _hexToColor(map['dropdownBorderColor'] ?? '#000000'),
      serviceIdTagColor: _hexToColor(map['serviceIdTagColor'] ?? '#bdbdbd'),
      serviceIdTextColor: _hexToColor(map['serviceIdTextColor'] ?? '#000000'),
      textFieldBorderColor: _hexToColor(map['textFieldBorderColor'] ?? '#9e9e9e'),
      pasteButtonBackgroundColor: _hexToColor(
        map['pasteButtonBackgroundColor'] ?? "#1976d2",
      ),
      pasteButtonTextColor: _hexToColor(map['pasteButtonTextColor']?? '#ffffff'),
      totalAmountColor: _hexToColor(map['totalAmountColor'] ?? '#2196f3'),
      orderButtonBackgroundColor: _hexToColor(
        map['orderButtonBackgroundColor'] ?? '#00bf63',
      ),
      orderButtonTextColor: _hexToColor(map['orderButtonTextColor'] ?? "#ffffff"),
      notificationIconColor: _hexToColor(map['notificationIconColor'] ?? '#ffffff'),
      categoryTextColor: _hexToColor(map['categoryTextColor'] ?? "#000000"),
    );
  }

  static Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      return Color(int.parse("FF$hex", radix: 16));
    } else {
      return Colors.black;
    }
  }
}
