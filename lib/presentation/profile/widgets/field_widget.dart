part of'../screens/account_setting_screen.dart';

class _FieldWidget extends StatelessWidget {
  const _FieldWidget({required this.label, required this.hint, required this.controller, required this.onChanged, this.isPassword = false});

  final String label;
  final String hint;
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700])),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          isPassword: isPassword,
          keyboardType: TextInputType.visiblePassword,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 0.6, color: CupertinoColors.systemGrey)),
          fillColor: Color(0xfff8f5f5),
          hintText: hint,
          hintStyle: context.text14Regular,
          inputTextStyle: context.text14Regular,
          isDense: true,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
