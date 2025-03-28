import 'dart:ui';

class SignupConfig {
  final List<Color> backgroundColor;
  SignupConfig({required this.backgroundColor});
  factory SignupConfig.fromMap(Map<String, dynamic> map) {
    return SignupConfig(backgroundColor: map['backgroundColor']);
  }
}
