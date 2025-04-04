import 'package:flutter/material.dart';

//// Control system for App
final Map<String, dynamic> environment = {
  "loginConfig": {
    "required": true,
    "enabled": true,
    "backgroundColor": ["#4c8479", "#2b5f56"],
    "enableAnimation": true,
    "animationAsset": "assets/animations/background.json",
    "backgroundImage": "assets/png/login_image.avif",

    // Texts
    "loginText": "Sign In",
    "panelText": "PANEL NAME",
    "forgotPasswordText": "Forgot Password?",
    "signupText": "Create New Account",
    "orText": "or",

    // Texts Style
    // #5ce1e6
    "loginColor": "#5ce1e6",
    "panelColor": "#FFFFFF",
    "forgotPasswordColor": "#FFFFFF",
    "createAccountColor": "#9481d4",
    "haveAccountColor": "#FFFFFF",
    "bottomSheetColor": "#000000",
    "bottomSheetColor2": "#555555",

    // Input Fields
    "emailHint": "Enter your email",
    "passwordHint": "Enter your password",
    "emailError": "Please enter a valid email",
    "passwordError": "Password must be at least 6 characters",

    // TextField Styles
    "textFieldBackgroundColor": "#4c8479",
    "textFieldBorderRadius": 18,
    "textFieldHintColor": "#FFFFFF",
    "textFieldIconColor": "#FFFFFF",

    // Button Styles
    "buttonBackgroundColor": "#ffde59",
    "buttonTextColor": "#000000",
    "buttonBorderRadius": 30,
    "buttonHeight": 52,

    // Feature Toggles
    "enableForgotPassword": true,
    "enableSignup": true,
    "enableSocialLogin": true,
    "googleLogin": true,
    "appleLogin": true,
  },

  "signupConfig": {
    //Colors
    "backgroundColor": ["#4c8479", "#2b5f56"],
    "cancelIconColor": Colors.white,

    // Input Fields
    "emailHint": "Enter your email",
    "passwordHint": "Enter your password",
    "whatsappHint": "Enter your whatsapp number",
    "fullnameHint": "Enter your fullName",
    "userNameHint": "Enter your userName",
    "retypePasswordHint": "Enter your retypePassword",
    "emailError": "Please enter a valid email",
    "passwordError": "Password must be at least 6 characters",
    "fullNameError": "Please enter your fullName",
    "userNameError": "Please enter userName",
    "whatsappError": "Please enter whatsapp number",
    "retypePasswordError": "Password must be at least 6 characters",

    // TextField Styles
    "textFieldBackgroundColor": "#4c8479",
    "textFieldBorderRadius": 18,
    "textFieldHintColor": Colors.grey,
    "textFieldIconColor": Colors.grey,
    'focusBorderColor': Colors.black,
    'inputTextColor': Colors.black,

     // Button Styles
    "buttonBackgroundColor": Colors.teal,
    "buttonTextColor": "#000000",
    "buttonBorderRadius": 30,
    "buttonHeight": 52,
  },

  "forgetPasswordConfig":{
    
    //Colors
    "backgroundColor": ["#4c8479", "#2b5f56"],
    'lockColor':'#2b524a',
    'buttonColor': '#bed2d0',
    'buttonTextColor': '#2b524a',
    'arrowBackColor': Colors.white,
    'textButtonColor':Colors.white,
    'cancelIconColor': '#2b524a',

    // TextField Styles
    "textFieldBackgroundColor": Colors.transparent,
    "textFieldBorderRadius": 18,
    "textFieldHintColor": "#bed2d0",
    "textFieldIconColor": "#bed2d0",
    "textFieldBorderColor":Colors.white,

  }

};
