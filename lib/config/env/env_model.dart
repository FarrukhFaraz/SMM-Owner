import 'package:sms_owner/config/env/config_model/signup_config.dart';

import 'config_model/login_config.dart';

class ENVModel {
  final LoginConfig loginConfig;
  final SignupConfig signupConfig;

  ENVModel({required this.loginConfig, required this.signupConfig});

  factory ENVModel.fromEnvironment(Map<String, dynamic> env) {
    return ENVModel(
      loginConfig: LoginConfig.fromMap(env["loginConfig"] ?? {}),
      signupConfig: SignupConfig.fromMap(env['signupConfig'] ?? {}),
    );
  }
}
