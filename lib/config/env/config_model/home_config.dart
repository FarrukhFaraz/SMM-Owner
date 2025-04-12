import 'package:flutter/material.dart';

class HomeConfig {

// colors
  final Color backContainerColor;
  final Color frontContainerColor;
  final Color walletContainerColor;
  final Color walletIconColor;
  final Color walletinfoTitleColor;
  final Color walletInfoValueColor;
  final Color backGroundColor;
  final Color menuIconColor;
  final Color logoTextColor;
  final Color dividerColor;
  final Color socialIconBackgroundColor;
  final Color socialIconColor;
  final Color searchButtonBackgroundColor;
  final Color searchButtonIconColor;
  final Color searchBorderColor;
  final Color dropdownBorderColor;
  final Color dropdownLabelColor;
  final Color serviceIdTagColor;
  final Color serviceIdTextColor;
  final Color textFieldBorderColor;
  final Color pasteButtonBackgroundColor;
  final Color pasteButtonTextColor;
  final Color quantityLabelColor;
  final Color quantityHintTextColor;
  final Color totalAmountColor;
  final Color orderButtonBackgroundColor;
  final Color orderButtonTextColor;
  final Color notificationIconColor;
  final Color notificationBadgeColor;
  final Color notificationBadgeTextColor;
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
    required this.dividerColor,
    required this.socialIconBackgroundColor,
    required this.socialIconColor,
    required this.searchButtonBackgroundColor,
    required this.searchButtonIconColor,
    required this.searchBorderColor,
    required this.dropdownBorderColor,
    required this.dropdownLabelColor,
    required this.serviceIdTagColor,
    required this.serviceIdTextColor,
    required this.textFieldBorderColor,
    required this.pasteButtonBackgroundColor,
    required this.pasteButtonTextColor,
    required this.quantityLabelColor,
    required this.quantityHintTextColor,
    required this.totalAmountColor,
    required this.orderButtonBackgroundColor,
    required this.orderButtonTextColor,
    required this.notificationIconColor,
    required this.notificationBadgeColor,
    required this.notificationBadgeTextColor,
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
      dividerColor: _hexToColor(map['dividerColor']),
      socialIconBackgroundColor: _hexToColor(map['socialIconBackgroundColor']),
      socialIconColor: _hexToColor(map['socialIconColor']),
      searchButtonBackgroundColor: _hexToColor(map['searchButtonBackgroundColor']),
      searchButtonIconColor: _hexToColor(map['searchButtonIconColor']),
      searchBorderColor: _hexToColor(map['searchBorderColor']),
      dropdownBorderColor: _hexToColor(map['dropdownBorderColor']),
      dropdownLabelColor: _hexToColor(map['dropdownLabelColor']),
      serviceIdTagColor: _hexToColor(map['serviceIdTagColor']),
      serviceIdTextColor: _hexToColor(map['serviceIdTextColor']),
      textFieldBorderColor: _hexToColor(map['textFieldBorderColor']),
      pasteButtonBackgroundColor: _hexToColor(map['pasteButtonBackgroundColor']),
      pasteButtonTextColor: _hexToColor(map['pasteButtonTextColor']),
      quantityLabelColor: _hexToColor(map['quantityLabelColor']),
      quantityHintTextColor: _hexToColor(map['quantityHintTextColor']),
      totalAmountColor: _hexToColor(map['totalAmountColor']),
      orderButtonBackgroundColor: _hexToColor(map['orderButtonBackgroundColor']),
      orderButtonTextColor: _hexToColor(map['orderButtonTextColor']),
      notificationIconColor: _hexToColor(map['notificationIconColor']),
      notificationBadgeColor: _hexToColor(map['notificationBadgeColor']),
      notificationBadgeTextColor: _hexToColor(map['notificationBadgeTextColor']),
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
