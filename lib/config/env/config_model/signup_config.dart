import 'package:flutter/material.dart';

class SignupConfig {
  // Colors
  final List<Color> backgroundColor;
  final Color cancelIconColor;

  // Input Fields
  final String emailHint;
  final String passwordHint;
  final String userNameHint;
  final String fullNameHint;
  final String whatsappHint;
  final String retypePasswordHint;
  final String emailError;
  final String passwordError;
  final String userNameError;
  final String fullNameError;
  final String whatsappError;
  final String retypePasswordError;

  // TextField Styles
  final Color textFieldBackgroundColor;
  final double textFieldBorderRadius;
  final Color textFieldHintColor;
  final Color textFieldIconColor;
  final Color focusBorderColor;
  final Color inputTextColor;

  // Button Styles
  final Color buttonBackgroundColor;
  final Color buttonTextColor;
  final double buttonBorderRadius;
  final double buttonHeight;

  SignupConfig({
    required this.backgroundColor,
    required this.cancelIconColor,
    required this.emailHint,
    required this.passwordHint,
    required this.userNameHint,
    required this.fullNameHint,
    required this.whatsappHint,
    required this.retypePasswordHint,
    required this.emailError,
    required this.passwordError,
    required this.userNameError,
    required this.fullNameError,
    required this.whatsappError,
    required this.retypePasswordError,
    required this.textFieldBackgroundColor,
    required this.textFieldBorderRadius,
    required this.textFieldHintColor,
    required this.textFieldIconColor,
    required this.focusBorderColor,
    required this.inputTextColor,
    required this.buttonBackgroundColor,
    required this.buttonTextColor,
    required this.buttonBorderRadius,
    required this.buttonHeight,
  });

  factory SignupConfig.fromMap(Map<String, dynamic> map) {
    return SignupConfig(
      backgroundColor: _hexToListColor(
        map["backgroundColor"] ?? ["#4c8479", "#2b5f56"],
      ),
      cancelIconColor: _hexToColor(map["cancelIconColor"] ?? "#FFFFFF"),
      emailHint: map["emailHint"] ?? "Enter your email",
      passwordHint: map["passwordHint"] ?? "Enter your password",
      userNameHint: map["userNameHint"] ?? "Enter your userName",
      fullNameHint: map["fullnameHint"] ?? "Enter your fullName",
      whatsappHint: map["whatsappHint"] ?? "Enter your WhatsApp number",
      retypePasswordHint:
          map["retypePasswordHint"] ?? "Enter your retypePassword",
      emailError: map["emailError"] ?? "Please enter a valid email",
      passwordError:
          map["passwordError"] ?? "Password must be at least 6 characters",
      userNameError: map["userNameError"] ?? "Please enter userName",
      fullNameError: map["fullNameError"] ?? "Please enter your fullName",
      whatsappError: map["whatsappError"] ?? "Please enter WhatsApp number",
      retypePasswordError:
          map["retypePasswordError"] ??
          "Password must be at least 6 characters",
      textFieldBackgroundColor: _hexToColor(
        map["textFieldBackgroundColor"] ?? "#2E2E2E",
      ),
      textFieldBorderRadius: double.parse(
        map["textFieldBorderRadius"].toString(),
      ),
      textFieldHintColor: _hexToColor(map["textFieldHintColor"]),
      textFieldIconColor: _hexToColor(map["textFieldIconColor"]),
      focusBorderColor: _hexToColor(map['focusBorderColor']),
      inputTextColor: _hexToColor(map['inputTextColor']),
      buttonBackgroundColor: _hexToColor(map["buttonBackgroundColor"]),
      buttonTextColor: _hexToColor(map["buttonTextColor"] ?? "#FFFFFF"),
      buttonBorderRadius: double.parse(map["buttonBorderRadius"].toString()),
      buttonHeight: double.parse(map["buttonHeight"].toString()),
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
    List<Color> list = [];
    if (value is String) {
      list = [_hexToColor(value)];
    } else if (value is List) {
      list = value.map((hex) => _hexToColor(hex.toString())).toList();
    } else {
      // ["#4c8479", "#2b5f56"]
      list = [Colors.white]; // fallback
    }
    return list.length > 1 ? list : [Color(0xff4c8479), Color(0xff2b5f56)];
  }
}
