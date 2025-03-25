//// Control system for App
final Map<String, dynamic> environment = {
  "loginConfig": {
    "required": true,
    "enabled": true,
    "backgroundColor": ["#4c8479", "#2b5f56"],
    "enableAnimation": true,
    "animationAsset": "assets/animations/background.json",
    "backgroundImage": "assets/images/login_bg.png",

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
};
