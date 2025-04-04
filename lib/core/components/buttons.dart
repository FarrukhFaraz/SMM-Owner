import 'package:flutter/material.dart';
import 'package:sms_owner/config/env/config_model/login_config.dart';

Widget buildLoginButton(LoginConfig loginConfig) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Container(
      width: double.infinity,
      height: loginConfig.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(loginConfig.buttonBorderRadius),
        color: loginConfig.buttonBackgroundColor,
      ),
      child: Center(
        child: Text(
          loginConfig.loginText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: loginConfig.buttonTextColor,
          ),
        ),
      ),
    ),
  );
}
//

Widget customButton(
  double height,
  double width,
  double borderRadius,
  Color buttonBackgroundColor,
  String buttonTitle,
  Color buttonTextColor,
  {double? fontSize,
  FontWeight? fontweight
  }
) {
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: buttonBackgroundColor,
    ),
    child: Center(
      child: Text(
        buttonTitle,
        style: TextStyle(
          fontSize: fontSize ?? 18,
          fontWeight:fontweight ?? FontWeight.bold,
          color: buttonTextColor,
        ),
      ),
    ),
  );
}
