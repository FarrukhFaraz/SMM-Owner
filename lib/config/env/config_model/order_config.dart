import 'package:flutter/material.dart';

class OrderConfig {
  // General Toggles
  final bool enabled;
  final bool enableFilter;
  final bool enableDropdown;

  // Header
  final String screenTitle;
  final String searchHint;
  final String filterButtonText;

  // Order Card Texts
  final String orderIdPrefix;
  final String expirationText;
  final String priceLabel;
  final String statusLabel;

  // Colors
  final Color backgroundColor;
  final Color topContainerColor;
  final Color menuIconColor;
  final Color logoTextColor;
  final Color orderHistoryTextColor;
  final Color cardColor;
  final Color cardBorderColor;
  final Color orderProductColor;
  final Color linkColor;
  final Color orderIdColor;
  final Color expirationColor;
  final Color searchFieldColor;
  final Color searchFieldTextColor;
  final Color priceColor;
  final Color statusColor;
  final Color hintTextColor;
  final Color dropdownBackgroundColor;
  final Color dropdownTextColor;

  // Buttons
  final Color buttonBackgroundColor;
  final Color buttonTextColor;
  final Color filterButtonColor;
  final Color filterIconColor;

  // Navigation Bar
  final Color navBarBackgroundColor;
  final Color navBarIconColor;
  final Color navBarSelectedColor;

  OrderConfig({
    required this.enabled,
    required this.enableFilter,
    required this.enableDropdown,
    required this.screenTitle,
    required this.topContainerColor,
    required this.menuIconColor,
    required this.logoTextColor,
    required this.orderHistoryTextColor,
    required this.linkColor,
    required this.searchHint,
    required this.filterButtonText,
    required this.orderIdPrefix,
    required this.expirationText,
    required this.priceLabel,
    required this.statusLabel,
    required this.searchFieldColor,
    required this.searchFieldTextColor,
    required this.orderProductColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.cardBorderColor,
    required this.orderIdColor,
    required this.expirationColor,
    required this.hintTextColor,
    required this.priceColor,
    required this.statusColor,
    required this.dropdownBackgroundColor,
    required this.dropdownTextColor,
    required this.buttonBackgroundColor,
    required this.buttonTextColor,
    required this.filterButtonColor,
    required this.filterIconColor,
    required this.navBarBackgroundColor,
    required this.navBarIconColor,
    required this.navBarSelectedColor,
  });

  factory OrderConfig.fromMap(Map<String, dynamic> map) {
    return OrderConfig(
      enabled: _parseBool(map['enabled'] ?? true),
      enableFilter: _parseBool(map['enableFilter'] ?? true),
      enableDropdown: _parseBool(map['enableDropdown'] ?? true),
      screenTitle: map['screenTitle'] ?? "Order History",
      searchHint: map['searchHint'] ?? "Search Order",
      topContainerColor: _hexToColor(map['topContainerColor'] ?? ''),
      menuIconColor: _hexToColor(map['menuIconColor'] ?? ''),
      orderHistoryTextColor: _hexToColor(
        map['orderHistoryTextColor'] ?? '#000000',
      ),
      orderProductColor: _hexToColor(map['orderProductTextColor'] ?? '#100f0d'),
      linkColor: _hexToColor(map['linkColor'] ?? '#5e17eb'),
      logoTextColor: _hexToColor(map['logoTextColor'] ?? '#ebc428'),
      searchFieldColor: _hexToColor(map['searchFieldColor'] ?? '#ebebeb'),
      searchFieldTextColor: _hexToColor(
        map['searchInputTextColor'] ?? '#100f0d',
      ),
      hintTextColor: _hexToColor(map['hintTextColor'] ?? '#100f0d'),

      filterButtonText: map['filterButtonText'] ?? "Filter",
      orderIdPrefix: map['orderIdPrefix'] ?? "Order ID:",
      expirationText: map['expirationText'] ?? "EXPIRATION:",
      priceLabel: map['priceLabel'] ?? "Price:",
      statusLabel: map['statusLabel'] ?? "Status:",
      backgroundColor: _hexToColor(map['backgroundColor'] ?? "#FFFFFF"),
      cardColor: _hexToColor(map['cardColor'] ?? "#FFFFFF"),
      cardBorderColor: _hexToColor(map['cardBorderColor'] ?? "#DDDDDD"),
      orderIdColor: _hexToColor(map['orderIdColor'] ?? "#000000"),
      expirationColor: _hexToColor(map['expirationColor'] ?? "#FF0000"),
      priceColor: _hexToColor(map['priceColor'] ?? "#000000"),
      statusColor: _hexToColor(map['statusColor'] ?? "#000000"),
      dropdownBackgroundColor: _hexToColor(
        map['dropdownBackgroundColor'] ?? "#FFFFFF",
      ),
      dropdownTextColor: _hexToColor(map['dropdownTextColor'] ?? "#000000"),
      buttonBackgroundColor: _hexToColor(
        map['buttonBackgroundColor'] ?? "#3A86FF",
      ),
      buttonTextColor: _hexToColor(map['buttonTextColor'] ?? "#FFFFFF"),
      filterButtonColor: _hexToColor(map['filterButtonColor'] ?? "#FF8C00"),
      filterIconColor: _hexToColor(map['filterIconColor'] ?? "#FFFFFF"),
      navBarBackgroundColor: _hexToColor(
        map['navBarBackgroundColor'] ?? "#0A0A0A",
      ),
      navBarIconColor: _hexToColor(map['navBarIconColor'] ?? "#BBBBBB"),
      navBarSelectedColor: _hexToColor(map['navBarSelectedColor'] ?? "#FFFFFF"),
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

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }
}
