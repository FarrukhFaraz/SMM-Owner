import 'package:flutter/material.dart';

class HomeConfig {
  // colors
  final Color backContainerColor;
  final Color frontContainerColor;
  final Color backGroundColor;
  final Color menuIconColor;
  final Color logoTextColor;
  final Color socialIconBackgroundColor;

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
    required this.socialIconBackgroundColor,
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
      backContainerColor: _hexToColor(map['backContainerColor']),
      frontContainerColor: _hexToColor(map['frontContainerColor']),
      walletContainerColor: _hexToColor(map['walletContainerColor']),
      walletIconColor: _hexToColor(map['walletIconColor']),
      walletinfoTitleColor: _hexToColor(map['walletinfoTitleColor']),
      walletInfoValueColor: _hexToColor(map['walletInfoValueColor']),
      backGroundColor: _hexToColor(map['backGroundColor']),
      menuIconColor: _hexToColor(map['menuIconColor']),
      logoTextColor: _hexToColor(map['logoTextColor']),
      socialIconBackgroundColor: _hexToColor(map['socialIconBackgroundColor']),
      textFieldColor: _hexToColor(map['textFieldColor']),
      hintTextColor: _hexToColor(map['hintTextColor']),
      searchButtonBackgroundColor: _hexToColor(
        map['searchButtonBackgroundColor'],
      ),
      searchButtonIconColor: _hexToColor(map['searchButtonIconColor']),
      dropDownColor: _hexToColor(map['dropDownColor']),
      dropDownTextColor: _hexToColor(map['dropDownTextColor']),
      dropDownFieldColor: _hexToColor(map['dropDownFieldColor']),
      dropdownBorderColor: _hexToColor(map['dropdownBorderColor']),
      serviceIdTagColor: _hexToColor(map['serviceIdTagColor']),
      serviceIdTextColor: _hexToColor(map['serviceIdTextColor']),
      textFieldBorderColor: _hexToColor(map['textFieldBorderColor']),
      pasteButtonBackgroundColor: _hexToColor(
        map['pasteButtonBackgroundColor'],
      ),
      pasteButtonTextColor: _hexToColor(map['pasteButtonTextColor']),
      totalAmountColor: _hexToColor(map['totalAmountColor']),
      orderButtonBackgroundColor: _hexToColor(
        map['orderButtonBackgroundColor'],
      ),
      orderButtonTextColor: _hexToColor(map['orderButtonTextColor']),
      notificationIconColor: _hexToColor(map['notificationIconColor']),
      categoryTextColor: _hexToColor(map['categoryTextColor']),
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
