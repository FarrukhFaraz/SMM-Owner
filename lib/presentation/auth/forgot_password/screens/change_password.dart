import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_textField.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/core/utils/app_color.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:sms_owner/presentation/auth/login/screens/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final ForgotPasswordCubit _forgotPasswordCubit = ForgotPasswordCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, envModel) {
        final forgotPassConfig = envModel.forgotpasswordConfig;
        return Scaffold(
          backgroundColor: AppColor.kWhite,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        NavigationService.pop();
                      },
                      icon: Icon(Icons.cancel, color: forgotPassConfig.cancelIconColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.lock,
                            size: 80,
                            color: forgotPassConfig.lockColor,
                          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5, end: 0),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Forgot Password?',
                          style: context.text30Medium?.copyWith(color: forgotPassConfig.lockColor, fontWeight: FontWeight.w900),
                        ).animate().fadeIn(duration: 800.ms),
                        SizedBox(height: 8),
                        Text(
                          'No worries, we’ll send you reset instructions',
                          style: context.text18Medium?.copyWith(color: forgotPassConfig.lockColor),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 1000.ms),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: forgotPassConfig.backgroundColor,
                          tileMode: TileMode.mirror,
                          end: AlignmentDirectional.topStart,
                          stops: [0.02, 1.5],
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 70),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, bottom: 10),
                              child: Text("Password :", style: context.text15Medium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextField(
                              controller: _passwordController,
                              fillColor: Colors.transparent,
                              isDense: false,
                              isPassword: true,
                              prefix: Icon(Icons.lock, color: forgotPassConfig.textFieldIconColor),
                              hintText: 'Enter your password',
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: forgotPassConfig.textFieldBorderColor, width: 1),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ).animate().fadeIn(duration: 1200.ms),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, bottom: 10),
                              child: Text(
                                "Confirm Password :",
                                style: context.text15Medium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextField(
                              controller: _confirmPasswordController,
                              fillColor: Colors.transparent,
                              isDense: false,
                              isPassword: true,
                              prefix: Icon(Icons.lock, color: forgotPassConfig.textFieldIconColor),
                              hintText: 'Confirm password',
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: forgotPassConfig.textFieldBorderColor, width: 1),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ).animate().fadeIn(duration: 1200.ms),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                              bloc: _forgotPasswordCubit,
                              listener: (context, state) {
                                if (state.status == ForgotPasswordStatus.passwordUpdated) {
                                  showSnackMessage(context, 'Password Changed Successfully');
                                  Navigator.of(
                                    context,
                                  ).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (context) => false);
                                } else if (state.status == ForgotPasswordStatus.error) {
                                  showSnackErrorMessage(context, state.error, 4);
                                }
                              },
                              builder: (context, state) {
                                return CustomButton(
                                  onPressed: () {
                                    if (_passwordController.text.isEmpty) {
                                      showSnackErrorMessage(context, 'Please enter Password', 3);
                                      return;
                                    }
                                    if (_passwordController.text.length < 6) {
                                      showSnackErrorMessage(context, 'Password must be 6 character long', 3);
                                      return;
                                    }
                                    if (_passwordController.text != _confirmPasswordController.text) {
                                      showSnackErrorMessage(context, "Password do not match", 4);
                                      return;
                                    }

                                    if (state.status == ForgotPasswordStatus.updatingPassword) return;

                                    _forgotPasswordCubit.updatePassword(email: widget.email, password: _passwordController.text);
                                  },
                                  buttonTitle: "Change Password",
                                  loading: state.status == ForgotPasswordStatus.updatingPassword,
                                  buttonColor: forgotPassConfig.buttonColor,
                                  textStyle: context.text15Medium?.copyWith(color: forgotPassConfig.buttonTextColor),
                                  borderRadius: 30,
                                );
                              },
                            ).animate().fadeIn(duration: 1400.ms).slideY(begin: 0.3, end: 0),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () => NavigationService.pop(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_back_rounded, color: forgotPassConfig.arrowBackColor),
                                SizedBox(width: 5),
                                Text(
                                  'Back to Login',
                                  style: context.text16Regular?.copyWith(
                                    color: forgotPassConfig.textButtonColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 1600.ms),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
