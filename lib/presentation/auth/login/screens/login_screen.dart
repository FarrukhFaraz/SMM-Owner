import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/core/utils/app_color.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/Home/home_screen.dart';
import 'package:sms_owner/presentation/auth/forgot_password/screens/forgot_password.dart';
import 'package:sms_owner/presentation/auth/login/cubit/login_cubit.dart';
import 'package:sms_owner/presentation/auth/sign_up/screens/sign_up.dart';
import 'package:sms_owner/presentation/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late LoginCubit _loginCubit;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginCubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, envModel) {
        final loginConfig = envModel.loginConfig;
        log("MyAPp ==> ${loginConfig.backgroundColor}");
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: loginConfig.backgroundColor),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    if (loginConfig.backgroundImage.isNotEmpty) ...{
                      Container(
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: MediaQuery.of(context).size.width * 0.60,
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
                                  image: AssetImage(
                                    loginConfig.backgroundImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            .animate()
                            .fade(duration: 500.ms)
                            .slideY(begin: 0.5, end: 0),
                      ),
                    },
                    const SizedBox(height: 22),
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
                    const SizedBox(height: 25),
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
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email or username is required';
                          }
                          // else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          //   return 'Enter a valid email';
                          // }
                          return null;
                        },
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
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (loginConfig.enableForgotPassword)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: TextButton(
                            onPressed: () {
                              NavigationService.push(ForgotPasswordScreen());
                            },
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
                    const SizedBox(height: 20),
                    Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: BlocConsumer<LoginCubit, LoginState>(
                                  listener: (context, state) {
                                    if (state.status == LoginStatus.success) {
                                      showSnackMessage(
                                        context,
                                        "Login Successfully",
                                      );
                                      NavigationService.pushReplacement(
                                        MainScreen(),
                                      );
                                    } else if (state.status ==
                                        LoginStatus.error) {
                                      showSnackErrorMessage(
                                        context,
                                        state.error,
                                        4,
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButton(
                                      onPressed: () {
                                        if (state.status ==
                                            LoginStatus.loading) {
                                          return;
                                        }
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }

                                        _loginCubit.login(
                                          username: emailController.text,
                                          password: passwordController.text,
                                        );
                                      },
                                      buttonTitle: loginConfig.loginText,
                                      loading:
                                          state.status == LoginStatus.loading,
                                      textStyle: context.text18Bold?.copyWith(
                                        color: loginConfig.buttonTextColor,
                                      ),
                                      buttonColor:
                                          loginConfig.buttonBackgroundColor,
                                      borderRadius: 30,
                                    );
                                  },
                                )
                                .animate()
                                .fade(duration: 500.ms)
                                .slideY(begin: 0.5, end: 0),
                          ),
                          if (loginConfig.enableSocialLogin)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: CustomButton(
                                    onPressed: () {
                                      NavigationService.push(HomeScreen());
                                    },
                                    buttonTitle: "Login with Google ",
                                    textStyle: context.smallCaption14500,
                                    buttonColor: AppColor.kWhite,
                                    assetImage: "assets/png/google_icon.png",
                                    hasImage: true,
                                    borderRadius: 30,
                                  )
                                  .animate()
                                  .fade(duration: 500.ms)
                                  .slideY(begin: 0.5, end: 0),
                            ),
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
                                const SizedBox(height: 20),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
