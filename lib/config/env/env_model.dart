import 'package:sms_owner/config/env/config_model/forgot_password_config.dart';
import 'package:sms_owner/config/env/config_model/home_config.dart';
import 'package:sms_owner/config/env/config_model/signup_config.dart';

import 'config_model/login_config.dart';

class ENVModel {
  final LoginConfig loginConfig;
  final SignupConfig signupConfig;
  final ForgotPasswordConfig forgotpasswordConfig;
  final HomeConfig homeConfig;

  ENVModel({
    required this.loginConfig,
    required this.signupConfig,
    required this.forgotpasswordConfig,
    required this.homeConfig,
  });

  factory ENVModel.fromEnvironment(Map<String, dynamic> env) {
    return ENVModel(
      loginConfig: LoginConfig.fromMap(env["loginConfig"] ?? {}),
      signupConfig: SignupConfig.fromMap(env['signupConfig'] ?? {}),
      forgotpasswordConfig: ForgotPasswordConfig.fromMap(
        env['forgetPasswordConfig'] ?? {},
      ),
      homeConfig: HomeConfig.fromMap(env['homeConfig']),
    );
  }
}
