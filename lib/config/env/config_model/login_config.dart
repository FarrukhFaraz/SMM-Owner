import 'package:flutter/material.dart';

class LoginConfig {
  //
  final bool required;
  final bool enabled;
  final List<Color> backgroundColor;
  final bool enableAnimation;
  final String animationAsset;
  final String backgroundImage;

  // Texts
  final String loginText;
  final String panelText;
  final String forgotPasswordText;
  final String signupText;
  final String orText;

  // Colors
  final Color loginColor;
  final Color panelColor;
  final Color forgotPasswordColor;
  final Color createAccountColor;
  final Color haveAccountColor;
  final Color bottomSheetColor;
  final Color bottomSheetColor2;

  // Input Fields
  final String emailHint;
  final String passwordHint;
  final String emailError;
  final String passwordError;

  // TextField Styles
  final Color textFieldBackgroundColor;
  final double textFieldBorderRadius;
  final Color textFieldHintColor;
  final Color textFieldIconColor;

  // Button Styles
  final Color buttonBackgroundColor;
  final Color buttonTextColor;
  final double buttonBorderRadius;
  final double buttonHeight;

  // Feature Toggles
  final bool enableForgotPassword;
  final bool enableSignup;
  final bool enableSocialLogin;
  final bool googleLogin;
  final bool appleLogin;

  LoginConfig({
    required this.required,
    required this.enabled,
    required this.backgroundColor,
    required this.enableAnimation,
    required this.animationAsset,
    required this.backgroundImage,
    required this.loginText,
    required this.panelText,
    required this.forgotPasswordText,
    required this.signupText,
    required this.orText,
    required this.loginColor,
    required this.panelColor,
    required this.forgotPasswordColor,
    required this.createAccountColor,
    required this.haveAccountColor,
    required this.emailHint,
    required this.passwordHint,
    required this.emailError,
    required this.passwordError,
    required this.textFieldBackgroundColor,
    required this.textFieldBorderRadius,
    required this.textFieldHintColor,
    required this.textFieldIconColor,
    required this.buttonBackgroundColor,
    required this.buttonTextColor,
    required this.buttonBorderRadius,
    required this.buttonHeight,
    required this.enableForgotPassword,
    required this.enableSignup,
    required this.enableSocialLogin,
    required this.googleLogin,
    required this.appleLogin,
    required this.bottomSheetColor,
    required this.bottomSheetColor2,
  });

  /// Factory constructor to create `LoginConfig` from a Map.
  factory LoginConfig.fromMap(Map<String, dynamic> map) {
    return LoginConfig(
      required: _parseBool(map["required"] ?? false),
      enabled: _parseBool(map["enabled"] ?? false),
      backgroundColor: _hexToListColor(map["backgroundColor"] ?? ["#FFFFFF"]),
      enableAnimation: _parseBool(map["enableAnimation"] ?? true),
      animationAsset: map["animationAsset"] ?? "",
      backgroundImage: map["backgroundImage"] ?? "",
      loginText: map["loginText"] ?? "Sign In",
      panelText: map["panelText"] ?? "Panel",
      forgotPasswordText: map["forgotPasswordText"] ?? "Forgot Password?",
      signupText: map["signupText"] ?? "Create New Account",
      orText: map["orText"] ?? "or",
      loginColor: _hexToColor(map["loginColor"] ?? "#5ce1e6"),
      panelColor: _hexToColor(map["panelColor"] ?? "#FFFFFF"),
      forgotPasswordColor: _hexToColor(map["forgotPasswordColor"] ?? "#FFFFFF"),
      createAccountColor: _hexToColor(map["createAccountColor"] ?? "#9481d4"),
      haveAccountColor: _hexToColor(map["haveAccountColor"] ?? "#FFFFFF"),
      emailHint: map["emailHint"] ?? "Enter your email",
      passwordHint: map["passwordHint"] ?? "Enter your password",
      emailError: map["emailError"] ?? "Please enter a valid email",
      passwordError:
          map["passwordError"] ?? "Password must be at least 6 characters",
      textFieldBackgroundColor: _hexToColor(
        map["textFieldBackgroundColor"] ?? "#2E2E2E",
      ),
      textFieldBorderRadius: double.parse(
        map["textFieldBorderRadius"].toString(),
      ),
      textFieldHintColor: _hexToColor(map["textFieldHintColor"] ?? "#AAAAAA"),
      textFieldIconColor: _hexToColor(map["textFieldIconColor"] ?? "#FFFFFF"),
      buttonBackgroundColor: _hexToColor(
        map["buttonBackgroundColor"] ?? "#3A86FF",
      ),
      buttonTextColor: _hexToColor(map["buttonTextColor"] ?? "#FFFFFF"),
      buttonBorderRadius: double.parse(map["buttonBorderRadius"].toString()),
      buttonHeight: double.parse(map["buttonHeight"].toString()),
      enableForgotPassword: _parseBool(map["enableForgotPassword"] ?? false),
      enableSignup: _parseBool(map["enableSignup"] ?? false),
      enableSocialLogin: _parseBool(map["enableSocialLogin"] ?? false),
      googleLogin: _parseBool(map["googleLogin"] ?? false),
      appleLogin: _parseBool(map["appleLogin"] ?? false),
      bottomSheetColor: _hexToColor(map['bottomSheetColor'] ?? "#000000"),
      bottomSheetColor2: _hexToColor(map['bottomSheetColor2'] ?? "#000000"),
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

  static _hexToListColor(dynamic value) {
    if (value is String) {
      return [_hexToListColor(value)];
    } else if (value is List) {
      return value.map((hex) => _hexToColor(hex.toString())).toList();
    } else {
      return [Colors.white]; // fallback
    }
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }
}
