import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_owner/config/env/config_model/login_config.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, envModel) {
        final loginConfig = envModel.loginConfig;

        return Scaffold(
          body: Stack(
            children: [
              // if (loginConfig.enableAnimation) Positioned.fill(child: Lottie.asset(loginConfig.animationAsset, fit: BoxFit.cover)),
              // if (loginConfig.backgroundImage.isNotEmpty) Positioned.fill(child: Image.asset(loginConfig.backgroundImage, fit: BoxFit.cover)),
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(colors: loginConfig.backgroundColor)),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Icon(Icons.more_horiz_outlined, color: Theme.of(context).scaffoldBackgroundColor, size: 26)],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Expanded(child: Center(child: Image.asset("assets/images/illustration.png", height: 200))),
                    Text(loginConfig.loginText, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: loginConfig.loginColor)),
                    Text(loginConfig.panelText, style: TextStyle(fontSize: 16, color: loginConfig.panelColor)),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: CustomTextField(
                        controller: emailController,
                        hintText: loginConfig.emailHint,
                        hintStyle: context.text12Medium?.copyWith(color: loginConfig.textFieldHintColor),
                        keyboardType: TextInputType.emailAddress,
                        fillColor: Theme.of(context).primaryColor,
                        prefix: Icon(Icons.person, color: Theme.of(context).scaffoldBackgroundColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(width: 2, color: Colors.white)),
                      ),
                    ),
                    // _buildTextField(Icons.email, loginConfig.emailHint, loginConfig),
                    // _buildTextField(Icons.lock, loginConfig.passwordHint, loginConfig, isPassword: true),
                    const SizedBox(height: 10),
                    if (loginConfig.enableForgotPassword)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: TextButton(onPressed: () {}, child: Text(loginConfig.forgotPasswordText, style: TextStyle(color: Colors.white70))),
                        ),
                      ),
                    const SizedBox(height: 20),
                    _buildLoginButton(loginConfig),
                    if (loginConfig.enableSocialLogin) _buildGoogleLoginButton(loginConfig),
                    if (loginConfig.enableSignup)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(loginConfig.orText, style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Text(loginConfig.signupText, style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(IconData icon, String hint, LoginConfig loginConfig, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: loginConfig.textFieldIconColor),
          hintText: hint,
          filled: true,
          fillColor: loginConfig.textFieldBackgroundColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(loginConfig.textFieldBorderRadius), borderSide: BorderSide.none),
          hintStyle: TextStyle(color: loginConfig.textFieldHintColor),
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginConfig loginConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: loginConfig.buttonHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(loginConfig.buttonBorderRadius), color: loginConfig.buttonBackgroundColor),
        child: Center(
          child: Text(loginConfig.loginText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: loginConfig.buttonTextColor)),
        ),
      ),
    );
  }

  Widget _buildGoogleLoginButton(LoginConfig loginConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        width: double.infinity,
        height: loginConfig.buttonHeight,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(loginConfig.buttonBorderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/google.png", height: 24),
            const SizedBox(width: 10),
            Text("Login with Google", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
