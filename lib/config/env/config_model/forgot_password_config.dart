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
      backgroundColor: _hexToListColor(map["backgroundColor"] ?? ["#FFFFFF"]),
      lockColor: _hexToColor(map['lockColor'] ?? '#2b524a'),
      buttonColor: _hexToColor(map['buttonColor'] ?? '#bed2d0'),
      buttonTextColor: _hexToColor(map['buttonTextColor'] ?? '#2b524a'),
      textFieldBackgroundColor: map["textFieldBackgroundColor"],
      textFieldBorderRadius: (map["textFieldBorderRadius"] ?? 30).toDouble(),
      textFieldHintColor: _hexToColor(map["textFieldHintColor"] ?? "#bed2d0"),
      textFieldIconColor: _hexToColor(map["textFieldIconColor"] ?? "#bed2d0"),
      textFieldBorderColor: map['textFieldBorderColor'],
      arrowBackColor: map['arrowBackColor'],
      textButtonColor: map['textButtonColor'],
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

  static List<Color> _hexToListColor(List<dynamic> hexList) {
    return hexList.map((hex) => _hexToColor(hex)).toList();
  }
}
