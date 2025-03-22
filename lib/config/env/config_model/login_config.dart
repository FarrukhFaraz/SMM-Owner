import 'dart:ui';

class LoginConfig {
  final bool required;
  final bool enabled;
  final Color backgroundColor;
  final bool enableAnimation;
  final String animationAsset;
  final String backgroundImage;

  // Texts
  final String loginText;
  final String panelText;
  final String forgotPasswordText;
  final String signupText;
  final String orText;

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
  });

  factory LoginConfig.fromMap(Map<String, dynamic> map) {
    return LoginConfig(
      required: map["required"] ?? false,
      enabled: map["enabled"] ?? false,
      backgroundColor: _hexToColor(map["backgroundColor"] ?? "#FFFFFF"),
      enableAnimation: map["enableAnimation"] ?? true,
      animationAsset: map["animationAsset"] ?? "",
      backgroundImage: map["backgroundImage"] ?? "",
      loginText: map["loginText"] ?? "Login",
      panelText: map["panelText"] ?? "Login Panel",
      forgotPasswordText: map["forgotPasswordText"] ?? "Forgot Password?",
      signupText: map["signupText"] ?? "Create New Account",
      orText: map["orText"] ?? "or",
      emailHint: map["emailHint"] ?? "Enter email",
      passwordHint: map["passwordHint"] ?? "Enter password",
      emailError: map["emailError"] ?? "Invalid email",
      passwordError: map["passwordError"] ?? "Password too short",
      textFieldBackgroundColor: _hexToColor(map["textFieldBackgroundColor"] ?? "#2E2E2E"),
      textFieldBorderRadius: (map["textFieldBorderRadius"] ?? 30).toDouble(),
      textFieldHintColor: _hexToColor(map["textFieldHintColor"] ?? "#AAAAAA"),
      textFieldIconColor: _hexToColor(map["textFieldIconColor"] ?? "#FFFFFF"),
      buttonBackgroundColor: _hexToColor(map["buttonBackgroundColor"] ?? "#3A86FF"),
      buttonTextColor: _hexToColor(map["buttonTextColor"] ?? "#FFFFFF"),
      buttonBorderRadius: (map["buttonBorderRadius"] ?? 30).toDouble(),
      buttonHeight: (map["buttonHeight"] ?? 50).toDouble(),
      enableForgotPassword: map["enableForgotPassword"] ?? false,
      enableSignup: map["enableSignup"] ?? false,
      enableSocialLogin: map["enableSocialLogin"] ?? false,
      googleLogin: map["googleLogin"] ?? false,
      appleLogin: map["appleLogin"] ?? false,
    );
  }

  static Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    return Color(int.parse("0xFF$hex"));
  }
}
