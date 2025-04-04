import 'package:flutter/material.dart';

class ForgotpasswordConfig {
  //Colors
  final List<Color> backgroundColor;
  final Color lockColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color arrowBackColor;
  final Color textbuttonColor;
  final Color cancelIconColor;

  // TextField Styles
  final Color textFieldBackgroundColor;
  final double textFieldBorderRadius;
  final Color textFieldHintColor;
  final Color textFieldIconColor;
  final Color textfieldBorderColor;

  ForgotpasswordConfig({
    required this.backgroundColor,
    required this.lockColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.textFieldBackgroundColor,
    required this.textFieldBorderRadius,
    required this.textFieldHintColor,
    required this.textFieldIconColor,
    required this.textfieldBorderColor,
    required this.arrowBackColor,
    required this.textbuttonColor,
    required this.cancelIconColor,
  });

  factory ForgotpasswordConfig.fromMap(Map<String, dynamic> map) {
    return ForgotpasswordConfig(
      backgroundColor: _hexToListColor(map["backgroundColor"] ?? ["#FFFFFF"]),
      lockColor: _hexToColor(map['lockColor'] ?? '#2b524a'),
      buttonColor: _hexToColor(map['buttonColor'] ?? '#bed2d0'),
      buttonTextColor: _hexToColor(map['buttonTextColor'] ?? '#2b524a'),
      textFieldBackgroundColor: map["textFieldBackgroundColor"],
      textFieldBorderRadius: (map["textFieldBorderRadius"] ?? 30).toDouble(),
      textFieldHintColor: _hexToColor(map["textFieldHintColor"] ?? "#bed2d0"),
      textFieldIconColor: _hexToColor(map["textFieldIconColor"] ?? "#bed2d0"),
      textfieldBorderColor: map['textFieldBorderColor'],
      arrowBackColor: map['arrowBackColor'],
      textbuttonColor: map['textButtonColor'],
     cancelIconColor:_hexToColor(map['cancelIconColor'] ?? "#2b524a")
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
