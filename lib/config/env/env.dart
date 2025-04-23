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
    "emailHint": "Enter your email or username",
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
    "cancelIconColor": "#ffffff",

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
    "textFieldHintColor": '#bcc4d4', //grey
    "textFieldIconColor": '#bcc4d4',
    'focusBorderColor': "#000000", //black
    'inputTextColor': "#000000",

    // Button Styles
    "buttonBackgroundColor": "#4c8479",
    "buttonTextColor": "#000000",
    "buttonBorderRadius": 30,
    "buttonHeight": 52,
  },

  "forgetPasswordConfig": {
    //Colors
    "backgroundColor": ["#4c8479", "#2b5f56"],
    'lockColor': '#2b524a',
    'buttonColor': '#bed2d0',
    'buttonTextColor': '#2b524a',
    'arrowBackColor': "#ffffff",
    'textButtonColor': "#ffffff",
    'cancelIconColor': '#2b524a',

    // TextField Styles
    "textFieldBackgroundColor": "",
    "textFieldBorderRadius": 18,
    "textFieldHintColor": "#bed2d0",
    "textFieldIconColor": "#bed2d0",
    "textFieldBorderColor": "#ffffff",
  },

  "homeConfig": {
    //Colors
    "backContainerColor": "#00bf63",
    "frontContainerColor": "#00695c",
    "walletContainerColor": "#372a28",
    "walletIconColor": "#ffc61a",
    "walletinfoTitleColor": "#fff4ea",
    "walletInfoValueColor": "#fff4ea",
    "backGroundColor": "#fff4ea",
    "menuIconColor": "#fff4ea",
    "logoTextColor": "#ebc428",
    "dividerColor": "#ffffff",

    "searchButtonBackgroundColor": "#2b524a",
    "searchButtonIconColor": "#000000",
    "searchBorderColor": "#9e9e9e",
    "dropdownBorderColor": "#000000",
    "dropdownLabelColor": "#000000",
    'dropDownColor': "#ffffff",
    'dropDownFieldColor': '#ebebeb',
    'dropDownTextColor': '#000000',
    "serviceIdTagColor": "#bdbdbd",
    "serviceIdTextColor": "#000000",
    "textFieldBorderColor": "#9e9e9e",
    "pasteButtonBackgroundColor": "#1976d2",
    "pasteButtonTextColor": "#ffffff",
    "quantityLabelColor": "#000000",
    "quantityHintTextColor": "#757575",
    "totalAmountColor": "#2196f3",
    "orderButtonBackgroundColor": "#00bf63",
    "orderButtonTextColor": "#ffffff",
    "notificationIconColor": "#ffffff",
    "notificationBadgeColor": "#ffc107",
    "notificationBadgeTextColor": "#000000",
    'categoryTextColor': "#000000",
    'textFieldColor': '#ebebeb',
    'hintTextColor': '#acb8c0',

    //
  },

  "orderConfig": {
    //
    "enabled": true,
    "enableFilter": true,
    "enableDropdown": true,
    //
    'topContainerColor': '#00695c',
    'menuIconColor': '#ffffff',
    'logoTextColor': '#ebc428',
    'orderHistoryTextColor': '#020001',
    "screenTitle": "Order History",
    "searchHint": "Search Order",
    'searchInputTextColor':'#100f0d',
    'hintTextColor': '#100f0d',
    "filterButtonText": "Filter",
    //
    "orderIdPrefix": "Order ID:",
    "expirationText": "EXPIRATION:",
    "priceLabel": "Price:",
    "statusLabel": "Status:",
    //
    "backgroundColor": "#F8F9FA",
    "cardColor": "#FFFFFF",
    "cardBorderColor": "#DDDDDD",
    "orderIdColor": "#2C3E50",
    'searchFieldColor': "#ebebeb",
    'orderProductColor': '#100f0d',
    'linkColor': "#5e17eb",
    "expirationColor": "#E74C3C",
    "priceColor": "#2C3E50",
    "statusColor": "#000000",
    //
    "dropdownBackgroundColor": "#FFFFFF",
    "dropdownTextColor": "#000000",
    //
    "buttonBackgroundColor": "#3A86FF",
    "buttonTextColor": "#FFFFFF",
    //
    "filterButtonColor": "#FFA500",
    "filterIconColor": "#FFFFFF",
  },

  "paymentConfig": {
  "tabBarBackgroundColor": "#00695c",
  "activeTabColor": "#FFFFFF",
  "inactiveTabColor": "#B0BEC5",
  "formBackgroundColor": "#FFFFFF",
  "inputFieldColor": "#F0F0F0",
  "inputTextColor": "#000000",
  "dropdownColor": "#FFFFFF",
  "checkboxColor": "#1D3C34",
  "submitButtonColor": "#4CAF50",
  "submitTextColor": "#FFFFFF",
  "historyCardColor": "#F5F5F5",
  "methodTextColor": "#1D3C34",
  "amountTextColor": "#4CAF50",
  'paymentContainerColor':'#FFFFFF',
  "dateTextColor": "#757575",
  "statusTextColor": "#FFFFFF"
}
};
