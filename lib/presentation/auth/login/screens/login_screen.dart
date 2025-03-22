import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_owner/config/env/config_model/login_config.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, envModel) {
        final loginConfig = envModel.loginConfig;

        return Scaffold(
          body: Stack(
            children: [
              if (loginConfig.enableAnimation) Positioned.fill(child: Lottie.asset(loginConfig.animationAsset, fit: BoxFit.cover)),
              if (loginConfig.backgroundImage.isNotEmpty) Positioned.fill(child: Image.asset(loginConfig.backgroundImage, fit: BoxFit.cover)),
              Column(
                children: [
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Logo here", style: TextStyle(color: Colors.white, fontSize: 18)), Icon(Icons.more_vert, color: Colors.white)],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: Center(child: Image.asset("assets/images/illustration.png", height: 200))),
                  Text(loginConfig.loginText, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(loginConfig.panelText, style: TextStyle(fontSize: 16, color: Colors.white70)),
                  const SizedBox(height: 20),
                  _buildTextField(Icons.email, loginConfig.emailHint, loginConfig),
                  _buildTextField(Icons.lock, loginConfig.passwordHint, loginConfig, isPassword: true),
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
