import 'package:flutter/material.dart';

class ForgotPasswordConfig {
  //Colors
  final List<Color> backgroundColor;
  final Color lockColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color arrowBackColor;
  final Color textButtonColor;
  final Color cancelIconColor;

  // TextField Styles
  final Color textFieldBackgroundColor;
  final double textFieldBorderRadius;
  final Color textFieldHintColor;
  final Color textFieldIconColor;
  final Color textFieldBorderColor;

  ForgotPasswordConfig({
    required this.backgroundColor,
    required this.lockColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.textFieldBackgroundColor,
    required this.textFieldBorderRadius,
    required this.textFieldHintColor,
    required this.textFieldIconColor,
    required this.textFieldBorderColor,
    required this.arrowBackColor,
    required this.textButtonColor,
    required this.cancelIconColor,
  });

  factory ForgotPasswordConfig.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordConfig(
      backgroundColor: _hexToListColor(map["backgroundColor"] ?? ["#4c8479", "#2b5f56"]),
      lockColor: _hexToColor(map['lockColor'] ?? '#2b524a'),
      buttonColor: _hexToColor(map['buttonColor'] ?? '#bed2d0'),
      buttonTextColor: _hexToColor(map['buttonTextColor'] ?? '#2b524a'),
      textFieldBackgroundColor: _hexToColor(map["textFieldBackgroundColor"]),
      textFieldBorderRadius: double.parse(map["textFieldBorderRadius"].toString()),
      textFieldHintColor: _hexToColor(map["textFieldHintColor"] ?? "#bed2d0"),
      textFieldIconColor: _hexToColor(map["textFieldIconColor"] ?? "#bed2d0"),
      textFieldBorderColor: _hexToColor(map['textFieldBorderColor']),
      arrowBackColor: _hexToColor(map['arrowBackColor']),
      textButtonColor: _hexToColor(map['textButtonColor']),
      cancelIconColor: _hexToColor(map['cancelIconColor'] ?? "#2b524a"),
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

   static List<Color> _hexToListColor(dynamic value) {
  if (value is String) {
    return [_hexToColor(value)];
  } else if (value is List) {
    return value.map((hex) => _hexToColor(hex.toString())).toList();
  } else {
    return [Colors.white]; // fallback
  }
}
}
