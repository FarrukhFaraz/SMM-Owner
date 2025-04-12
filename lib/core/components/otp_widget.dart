import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key, required this.controller, this.onCompleted});

  final TextEditingController controller;
  final void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)), borderRadius: BorderRadius.circular(20)),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(decoration: defaultPinTheme.decoration?.copyWith(color: Color.fromRGBO(234, 239, 243, 1)));

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      keyboardType: TextInputType.number,
      length: 6,
      controller: controller,
      animationDuration: Duration(seconds: 1),
      closeKeyboardWhenCompleted: true,
      validator: (s) {
        return s == '000000' ? 'Pin is incorrect' : null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      autofocus: true,
      animationCurve: Curves.easeInOut,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      pinAnimationType: PinAnimationType.fade,
      showCursor: true,
      onCompleted: onCompleted,
    );
  }
}
