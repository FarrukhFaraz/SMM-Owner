import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/utils/app_color.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  //Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, envModel) {
        final signupConfig = envModel.signupConfig;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        gradient: LinearGradient(
                          colors: signupConfig.backgroundColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 0, right: 10),
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                NavigationService.pop();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: signupConfig.cancelIconColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                        "Let's",
                                        style: GoogleFonts.poppins(
                                          fontSize: 35,
                                          color: signupConfig.cancelIconColor,
                                        ),
                                      )
                                      .animate()
                                      .fade(duration: 800.ms)
                                      .slideY(begin: -0.5, end: 0),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                        'Create Your\nAccount',
                                        style: GoogleFonts.poppins(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w900,
                                          color: signupConfig.cancelIconColor,
                                        ),
                                      )
                                      .animate()
                                      .fade(duration: 800.ms)
                                      .slideY(begin: -0.5, end: 0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: fullNameController,
                              hintText: signupConfig.fullNameHint,
                              hintStyle: context.text12Medium?.copyWith(
                                color: signupConfig.textFieldHintColor,
                              ),
                              keyboardType: TextInputType.name,
                              fillColor: Colors.transparent,
                              prefix: Icon(
                                Icons.person,
                                color: signupConfig.textFieldIconColor,
                                size: 20,
                              ),
                               inputTextStyle: context.text12Medium?.copyWith(
                                color: signupConfig.inputTextColor,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Full name is required';
                                }
                                return null;
                              },
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: signupConfig.focusBorderColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: usernameController,
                              hintText: signupConfig.userNameHint,
                              hintStyle: context.text12Medium?.copyWith(
                                color: signupConfig.textFieldHintColor,
                              ),
                              keyboardType: TextInputType.name,
                              fillColor: Colors.transparent,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Username is required';
                                }
                                return null;
                              },

                              prefix: Icon(
                                Icons.person,
                                color: signupConfig.textFieldIconColor,
                                size: 20,
                              ),
                               inputTextStyle: context.text12Medium?.copyWith(
                                color: signupConfig.inputTextColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: signupConfig.focusBorderColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: emailController,
                              hintText: signupConfig.emailHint,
                              hintStyle: context.text12Medium?.copyWith(
                                color: signupConfig.textFieldHintColor,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email is required';
                                } else if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.emailAddress,
                              fillColor: Colors.transparent,
                              prefix: Icon(
                                Icons.email,
                                color: signupConfig.textFieldIconColor,
                                size: 20,
                              ),
                               inputTextStyle: context.text12Medium?.copyWith(
                                color: signupConfig.inputTextColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: signupConfig.focusBorderColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: whatsappController,
                              hintText: signupConfig.whatsappHint,
                              hintStyle: context.text12Medium?.copyWith(
                                color: signupConfig.textFieldHintColor,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Phone number is required';
                                } else if (!RegExp(
                                  r'^[0-9]{10,15}$',
                                ).hasMatch(value)) {
                                  return 'Enter a valid phone number';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.phone,
                              fillColor: Colors.transparent,
                              prefix: Icon(
                                Icons.call,
                                color: signupConfig.textFieldIconColor,
                                size: 20,
                              ),
                               inputTextStyle: context.text12Medium?.copyWith(
                                color: signupConfig.inputTextColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: signupConfig.focusBorderColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: passwordController,
                              hintText: signupConfig.passwordHint,
                              hintStyle: context.text12Medium?.copyWith(
                                color: signupConfig.textFieldHintColor,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              inputTextStyle: context.text12Medium?.copyWith(
                                color: signupConfig.inputTextColor,
                              ),
                              fillColor: Colors.transparent,
                              isPassword: true,
                              prefix: Icon(
                                Icons.lock,
                                color: signupConfig.textFieldIconColor,
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: signupConfig.focusBorderColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: retypePasswordController,
                              hintText: signupConfig.retypePasswordHint,
                              inputTextStyle: context.text12Medium?.copyWith(
                                color: signupConfig.inputTextColor,
                              ),
                              hintStyle: context.text12Medium?.copyWith(
                                color: signupConfig.textFieldHintColor,
                              ),
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.visiblePassword,
                              fillColor: Colors.transparent,
                              isPassword: true,
                              prefix: Icon(
                                Icons.lock,
                                color: signupConfig.textFieldIconColor,
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: signupConfig.focusBorderColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: checkValue,
                                  onChanged: (value) {
                                    checkValue = !checkValue;
                                    setState(() {});
                                  },
                                  activeColor: AppColor.kcPrimaryColor,
                                  checkColor: AppColor.kWhite,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: AppColor.kcPrimaryDark,
                                  ),
                                ),
                                Text(
                                  "I agree to the ",
                                  style: context.text15Medium?.copyWith(
                                    color: signupConfig.focusBorderColor,
                                  ),
                                ),
                                Text(
                                  "Terms & Privacy",
                                  style: TextStyle(
                                    color: AppColor.kcPrimaryDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            CustomButton(
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    if (!checkValue) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Please accept the Terms & Privacy",
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    // All validated, proceed
                                    NavigationService.pushReplacement(MainScreen());
                                  },
                                  buttonTitle: "Sign up",
                                  buttonColor:
                                      signupConfig.buttonBackgroundColor,
                                  textStyle: context.text15Medium?.copyWith(
                                    color: AppColor.kWhite,
                                  ),
                                  borderRadius: 30,
                                )
                                .animate()
                                .fade(duration: 500.ms)
                                .slideY(begin: 0.5, end: 0),
                            SizedBox(height: 15),
                            Center(
                              child: Text(
                                "or",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),

                            SizedBox(height: 10),
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/png/google_icon.png',
                                height: 20,
                              ),
                              label: Text(
                                "Signup with Google",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Have an account?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    NavigationService.pop();
                                  },
                                  child: Text(
                                    " Sign In",
                                    style: TextStyle(
                                      color: signupConfig.buttonBackgroundColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
