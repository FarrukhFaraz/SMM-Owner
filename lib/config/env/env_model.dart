import 'package:sms_owner/config/env/config_model/forgot_password_config.dart';
import 'package:sms_owner/config/env/config_model/home_config.dart';
import 'package:sms_owner/config/env/config_model/order_config.dart';
import 'package:sms_owner/config/env/config_model/payment_config.dart';
import 'package:sms_owner/config/env/config_model/signup_config.dart';
import 'config_model/login_config.dart';

class ENVModel {
  final LoginConfig loginConfig;
  final SignupConfig signupConfig;
  final ForgotPasswordConfig forgotpasswordConfig;
  final HomeConfig homeConfig;
  final OrderConfig orderConfig;
  final PaymentConfig paymentConfig;

  ENVModel({
    required this.loginConfig,
    required this.signupConfig,
    required this.forgotpasswordConfig,
    required this.homeConfig,
    required this.orderConfig,
    required this.paymentConfig,
  });

  factory ENVModel.fromEnvironment(Map<String, dynamic> env) {
    return ENVModel(
      loginConfig: LoginConfig.fromMap(env['loginConfig'] ?? {}),
      signupConfig: SignupConfig.fromMap(env['signupConfig'] ?? {}),
      forgotpasswordConfig: ForgotPasswordConfig.fromMap(
        env['forgetPasswordConfig'] ?? {},
      ),
      homeConfig: HomeConfig.fromMap(env['homeConfig'] ?? {}),
      orderConfig: OrderConfig.fromMap(env['orderConfig'] ?? {}),
      paymentConfig: PaymentConfig.fromMap(env['paymentConfig'] ?? {}),
    );
  }
}
