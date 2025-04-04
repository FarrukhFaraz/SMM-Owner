import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/custom_textfield.dart';
import 'package:sms_owner/core/utils/navigation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvCubit, ENVModel>(
      builder: (context, envModel) {
        final forgotPassConfig = envModel.forgotpasswordConfig;
        return Scaffold(
          backgroundColor: Colors.white,

          //BottomSheet
          bottomSheet: BottomSheet(
            onClosing: () {},
            builder: (_) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: forgotPassConfig.backgroundColor,
                    tileMode: TileMode.mirror,
                    end: AlignmentDirectional.topStart,
                    stops: [0.02, 1.5],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 10),
                        child: Text(
                          "Email :",
                          style: context.text15Medium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: _emailController,
                        fillColor: Colors.transparent,
                        prefix: Icon(
                          Icons.email_outlined,
                          color: forgotPassConfig.textFieldIconColor,
                        ),
                        hintText: 'Enter your Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: forgotPassConfig.textfieldBorderColor,
                          ),
                        ),

                        keyboardType: TextInputType.emailAddress,
                      ).animate().fadeIn(duration: 1200.ms),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: customButton(
                            50,
                            double.infinity,
                            30,
                            forgotPassConfig.buttonColor,
                            "Send Code on Email",
                            forgotPassConfig.buttonTextColor,
                            fontSize: 15,
                            fontweight: FontWeight.w200,
                          )
                          .animate()
                          .fadeIn(duration: 1400.ms)
                          .slideY(begin: 0.3, end: 0),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            color: forgotPassConfig.arrowBackColor,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Back to Login',
                            style: context.text16Regular?.copyWith(
                              color: forgotPassConfig.textbuttonColor,
                              decoration: TextDecoration.underline
                            )
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 1600.ms),
                  ],
                ),
              );
            },
          ),

          //
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    //top cancel icon
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          NavigationService.pop();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: forgotPassConfig.cancelIconColor,
                        ),
                      ),
                    ),

                    //lock icon
                    Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Icon(
                            Icons.lock,
                            size: 80,
                            color: forgotPassConfig.lockColor,
                          )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: -0.5, end: 0),
                    ),

                    //
                    SizedBox(height: 20),
                    Text(
                      'Forgot Password?',
                      style: context.text30Medium?.copyWith(
                        color: forgotPassConfig.lockColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ).animate().fadeIn(duration: 800.ms),

                    //
                    SizedBox(height: 8),
                    Text(
                      'No worries, we’ll send you reset instructions',
                      style: context.text18Medium?.copyWith(
                        color: forgotPassConfig.lockColor,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 1000.ms),
                    SizedBox(height: 30),
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
