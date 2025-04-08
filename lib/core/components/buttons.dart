import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    required this.buttonColor,
    required this.buttonTitle,
    this.textStyle,
    this.loading = false,
    required this.onPressed,
    this.hasImage = false,
    this.assetImage,
  });

  final double? height;
  final double? width;
  final double? borderRadius;
  final Color buttonColor;
  final String buttonTitle;
  final TextStyle? textStyle;
  final bool loading;
  final void Function() onPressed;
  final bool hasImage;
  final String? assetImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 10), color: buttonColor),
        child:
            loading
                ? Center(child: CircularProgressIndicator())
                : hasImage
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset(assetImage ?? '', height: 24), const SizedBox(width: 10), Text(buttonTitle, style: textStyle)],
                )
                : Center(child: Text(buttonTitle, style: textStyle)),
      ),
    );
  }
}

// Widget buildLoginButton(LoginConfig loginConfig) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 40),
//     child: Container(
//       width: double.infinity,
//       height: loginConfig.buttonHeight,
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(loginConfig.buttonBorderRadius), color: loginConfig.buttonBackgroundColor),
//       child: Center(
//         child: Text(loginConfig.loginText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: )),
//       ),
//     ),
//   );
// }
// //
//
// Widget customButton(
//   double height,
//   double width,
//   double borderRadius,
//   Color buttonBackgroundColor,
//   String buttonTitle,
//   Color buttonTextColor, {
//   double? fontSize,
//   FontWeight? fontweight,
// }) {
//   return Container(
//     width: double.infinity,
//     height: height,
//     decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: buttonBackgroundColor),
//     child: Center(
//       child: Text(buttonTitle, style: TextStyle(fontSize: fontSize ?? 18, fontWeight: fontweight ?? FontWeight.bold, color: buttonTextColor)),
//     ),
//   );
// }
