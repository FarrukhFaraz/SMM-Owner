import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/config_model/login_config.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/auth/sign_up/screens/sign_up.dart';

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
          bottomSheet: BottomSheet(
            onClosing: () {},
            builder: (_) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      loginConfig.bottomSheetColor2,
                      loginConfig.bottomSheetColor,
                    ],
                    tileMode: TileMode.mirror,
                    end: AlignmentDirectional.topStart,
                    stops: [0.02, 1.5],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    buildLoginButton(loginConfig),
                    if (loginConfig.enableSocialLogin)
                      _buildGoogleLoginButton(loginConfig),
                    if (loginConfig.enableSignup)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            loginConfig.orText,
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              NavigationService.push(SignUpScreen());
                            },
                            child: Text(
                              loginConfig.signupText,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: loginConfig.backgroundColor),
              ),
              child: Stack(
                children: [
                  // if (loginConfig.enableAnimation)
                  //Positioned.fill(child: Lottie.asset(loginConfig.animationAsset, fit: BoxFit.cover)),
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      if (loginConfig.backgroundImage.isNotEmpty) ...{
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.66,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(120),
                            border: Border.all(color: Colors.white38),
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Colors.white),
                              BoxShadow(color: Color(0xff4c8479)),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(120),
                              gradient: RadialGradient(
                                colors: loginConfig.backgroundColor,
                              ),
                              image: DecorationImage(
                                image: AssetImage(loginConfig.backgroundImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      },
                      const SizedBox(height: 20),
                      Text(
                        loginConfig.loginText,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: loginConfig.loginColor,
                        ),
                      ),
                      Text(
                        loginConfig.panelText,
                        style: TextStyle(
                          fontSize: 16,
                          color: loginConfig.panelColor,
                        ),
                      ),
                      const SizedBox(height: 26),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: CustomTextField(
                          controller: emailController,
                          hintText: loginConfig.emailHint,
                          hintStyle: context.text12Medium?.copyWith(
                            color: loginConfig.textFieldHintColor,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          fillColor: Colors.transparent,
                          prefix: Icon(
                            Icons.person,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: CustomTextField(
                          controller: passwordController,
                          hintText: loginConfig.passwordHint,
                          hintStyle: context.text12Medium?.copyWith(
                            color: loginConfig.textFieldHintColor,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          fillColor: Colors.transparent,
                          prefix: Icon(
                            Icons.lock,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      if (loginConfig.enableForgotPassword)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                loginConfig.forgotPasswordText,
                                style: TextStyle(
                                  color: Colors.white70,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //
  Widget _buildGoogleLoginButton(LoginConfig loginConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        width: double.infinity,
        height: loginConfig.buttonHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(loginConfig.buttonBorderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/png/google_icon.png", height: 24),
            const SizedBox(width: 10),
            Text("Login with Google ", style: context.smallCaption14500),
          ],
        ),
      ),
    );
  }
}
