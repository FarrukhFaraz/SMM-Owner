// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class CustomTextField extends StatefulWidget {
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     this.prefix,
//     this.suffix,
//     this.isPassword = false,
//     this.autofocus,
//     this.maxLines,
//     this.inputFormatter,
//     this.keyboardType,
//     this.border,
//     this.focusBorderColor,
//     this.errorBorderColor,
//     this.inputTextStyle,
//     this.fillColor,
//     this.hintText,
//     this.hintStyle,
//     this.contentPadding,
//     this.onChanged,
//     this.validator,
//     this.isDense,
//   });
//
//   final TextEditingController controller;
//   final Widget? prefix;
//   final Widget? suffix;
//   final bool isPassword;
//   final bool? autofocus;
//   final bool? isDense;
//   final int? maxLines;
//   final List<TextInputFormatter>? inputFormatter;
//   final TextInputType? keyboardType;
//   final InputBorder? border;
//   final Color? focusBorderColor;
//   final TextStyle? inputTextStyle;
//   final Color? errorBorderColor;
//   final Color? fillColor;
//   final String? hintText;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextStyle? hintStyle;
//   final void Function(String)? onChanged;
//   final String? Function(String?)? validator;
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _isObscure = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       obscureText: widget.isPassword == true ? _isObscure : false,
//       autofocus: widget.autofocus ?? false,
//       maxLines: widget.maxLines,
//       onChanged: widget.onChanged,
//       inputFormatters: widget.inputFormatter,
//
//       validator: widget.validator,
//       keyboardType: widget.keyboardType,
//       style: widget.inputTextStyle,
//       decoration: InputDecoration(
//         prefix: widget.prefix,
//         suffix:
//             widget.isPassword
//                 ? GestureDetector(
//                   onTap: () {
//                     _isObscure = !_isObscure;
//                     setState(() {});
//                   },
//                   child: Icon(_isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
//                 )
//                 : widget.suffix,
//         border: widget.border,
//         focusedBorder: widget.border?.copyWith(borderSide: BorderSide(color: widget.focusBorderColor ?? widget.border!.borderSide.color)),
//         enabledBorder: widget.border,
//         errorBorder: widget.border?.copyWith(borderSide: BorderSide(color: widget.errorBorderColor ?? widget.border!.borderSide.color)),
//         fillColor: widget.fillColor,
//         filled: true,
//         isDense: widget.isDense,
//         contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         hintText: widget.hintText,
//         hintStyle: widget.hintStyle,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.prefix,
    this.suffix,
    this.isPassword = false,
    this.autofocus,
    this.maxLines,
    this.inputFormatter,
    this.keyboardType,
    this.border,
    this.focusBorderColor,
    this.errorBorderColor,
    this.inputTextStyle,
    this.fillColor,
    this.hintText,
    this.hintStyle,
    this.contentPadding,
    this.onChanged,
    this.validator,
    this.isDense,
  });

  final TextEditingController controller;
  final Widget? prefix;
  final Widget? suffix;
  final bool isPassword;
  final bool? autofocus;
  final bool? isDense;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final Color? focusBorderColor;
  final TextStyle? inputTextStyle;
  final Color? errorBorderColor;
  final Color? fillColor;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscure : false,
      autofocus: widget.autofocus ?? false,
      maxLines: widget.maxLines ?? 1,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatter,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      style: widget.inputTextStyle,
      decoration: InputDecoration(
        prefixIcon: widget.prefix != null ? Padding(padding: const EdgeInsets.only(left: 8, right: 4), child: widget.prefix) : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon:
            widget.isPassword
                ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(_isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  ),
                )
                : (widget.suffix != null ? Padding(padding: const EdgeInsets.only(right: 8), child: widget.suffix) : null),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        border: widget.border,
        focusedBorder: widget.border?.copyWith(borderSide: BorderSide(color: widget.focusBorderColor ?? widget.border!.borderSide.color, width: 1.3)),
        enabledBorder: widget.border,
        errorBorder: widget.border?.copyWith(borderSide: BorderSide(color: widget.errorBorderColor ?? widget.border!.borderSide.color)),
        fillColor: widget.fillColor,
        filled: true,
        isDense: widget.isDense ?? true,
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
      ),
    );
  }
}
