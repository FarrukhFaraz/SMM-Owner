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

  