import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_owner/config/env/config_model/signup_config.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/utils/navigation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  //

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
                    // top Container
                    Container(
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                        gradient: LinearGradient(colors: signupConfig.backgroundColor),
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
                              icon: Icon(Icons.cancel, color: signupConfig.cancelIconColor),
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
                                    style: GoogleFonts.poppins(fontSize: 35, color: signupConfig.cancelIconColor),
                                  ).animate().fade(duration: 800.ms).slideY(begin: -0.5, end: 0),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Create Your\nAccount',
                                    style: GoogleFonts.poppins(fontSize: 35, fontWeight: FontWeight.w900, color: signupConfig.cancelIconColor),
                                  ).animate().fade(duration: 800.ms).slideY(begin: -0.5, end: 0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // fields
                    SizedBox(height: 20),
                    _buildTextField(signupConfig, fullNameController, Icons.person, signupConfig.fullNameHint),
                    _buildTextField(signupConfig, usernameController, Icons.person, signupConfig.userNameHint),
                    _buildTextField(signupConfig, emailController, Icons.email, signupConfig.emailHint),
                    _buildTextField(signupConfig, whatsappController, Icons.call, signupConfig.whatsappHint),
                    _buildTextField(
                      signupConfig,
                      passwordController,
                      Icons.password,
                      signupConfig.passwordHint,
                      isPassword: true,
                      suffix: Icon(Icons.visibility, color: signupConfig.textFieldIconColor),
                    ),
                    _buildTextField(
                      signupConfig,
                      retypePasswordController,
                      Icons.lock,
                      signupConfig.retypePasswordHint,
                      isPassword: true,
                      suffix: Icon(Icons.visibility, color: signupConfig.textFieldIconColor),
                    ),

                    //terms and conditions check
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Text("I agree to the ", style: TextStyle(color: signupConfig.focusBorderColor)),
                          Text("Terms & Privacy", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    //Signup Button
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: customButton(
                        50,
                        double.infinity,
                        30,
                        signupConfig.buttonBackgroundColor,
                        'Sign up',
                        Colors.white,
                      ).animate().fade(duration: 500.ms).slideY(begin: 0.5, end: 0),
                    ),
                    SizedBox(height: 15),
                    Center(child: Text("or", style: TextStyle(color: Colors.black))),

                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.asset('assets/png/google_icon.png', height: 20),
                        label: Text("Signup with Google", style: TextStyle(color: Colors.black)),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Have an account?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                              NavigationService.pop();
                            },
                            child: Text(" Sign In", style: TextStyle(color: signupConfig.buttonBackgroundColor, fontWeight: FontWeight.bold)),
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

  //
  Widget _buildTextField(
    SignupConfig signupConfig,
    TextEditingController controller,
    IconData prefixIcon,
    String hint, {
    TextInputType? textInputKeyBoardType,
    bool? isPassword,
    Icon? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: CustomTextField(
        controller: controller,
        hintText: hint,
        focusBorderColor: signupConfig.focusBorderColor,
        hintStyle: context.text12Medium?.copyWith(color: signupConfig.textFieldHintColor),

        inputTextStyle: TextStyle(color: signupConfig.inputTextColor),
        keyboardType: textInputKeyBoardType ?? TextInputType.emailAddress,
        fillColor: Colors.transparent,
        isPassword: isPassword ?? false,
        prefix: Icon(prefixIcon, color: signupConfig.textFieldIconColor, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(width: 1, color: signupConfig.focusBorderColor)),
        suffix: suffix,
      ),
    );
  }
}
