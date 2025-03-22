//// Control system for App
final Map<String, dynamic> environment = {
  "loginConfig": {
    "required": true,
    "enabled": true,
    "backgroundColor": "#1E1E1E",
    "enableAnimation": true,
    "animationAsset": "assets/animations/background.json",
    "backgroundImage": "assets/images/login_bg.png",

    // Texts
    "loginText": "Sign In",
    "panelText": "Welcome to MyApp",
    "forgotPasswordText": "Forgot Password?",
    "signupText": "Create New Account",
    "orText": "or",

    // Input Fields
    "emailHint": "Enter your email",
    "passwordHint": "Enter your password",
    "emailError": "Please enter a valid email",
    "passwordError": "Password must be at least 6 characters",

    // TextField Styles
    "textFieldBackgroundColor": "#2E2E2E",
    "textFieldBorderRadius": 30,
    "textFieldHintColor": "#AAAAAA",
    "textFieldIconColor": "#FFFFFF",

    // Button Styles
    "buttonBackgroundColor": "#3A86FF",
    "buttonTextColor": "#FFFFFF",
    "buttonBorderRadius": 30,
    "buttonHeight": 50,

    // Feature Toggles
    "enableForgotPassword": true,
    "enableSignup": true,
    "enableSocialLogin": true,
    "googleLogin": true,
    "appleLogin": true,
  },
};
