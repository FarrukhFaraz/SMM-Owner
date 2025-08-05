
import 'package:flutter/services.dart';

class RangeInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    // Allow empty (user is deleting)
    if (text.isEmpty) return newValue;

    // Disallow leading zeros (except "0" itself)
    if (text.length > 1 && text.startsWith('0')) {
      return oldValue;
    }

    // Digits only
    final intValue = int.tryParse(text);
    if (intValue == null) return oldValue;

    // Check bounds
    if (intValue < min || intValue > max) {
      return oldValue;
    }

    return newValue;
  }
}
