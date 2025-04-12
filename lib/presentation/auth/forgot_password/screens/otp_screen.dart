import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';
import 'package:sms_owner/config/env/env_model.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/buttons.dart';
import 'package:sms_owner/core/components/otp_widget.dart';
import 'package:sms_owner/core/components/snack_message.dart';
import 'package:sms_owner/core/cubit/timer/timer_cubit.dart';
import 'package:sms_owner/core/utils/app_color.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:sms_owner/presentation/auth/forgot_password/screens/change_password.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TimerCubit _timerCubit = TimerCubit();

  final ForgotPasswordCubit _forgotPasswordCubit = ForgotPasswordCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timerCubit.update(600);
    _timerCubit.start();
  }

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
                          'Verify OTP',
                          style: context.text30Medium?.copyWith(color: forgotPassConfig.lockColor, fontWeight: FontWeight.w900),
                        ).animate().fadeIn(duration: 800.ms),
                        SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Otp Sent to ', style: context.text16Regular?.copyWith(color: AppColor.kGreen)),
                              TextSpan(text: widget.email, style: context.text18Medium?.copyWith(color: AppColor.blackText)),
                              TextSpan(text: '. Please verify OTP', style: context.text16Regular?.copyWith(color: forgotPassConfig.lockColor)),
                            ],
                          ),
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
                              child: Text("OTP :", style: context.text15Medium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: OtpWidget(
                              controller: _otpController,
                              onCompleted: (otp) {
                                print('_OtpScreenState.build:::onCompleted OTP: $otp');
                              },
                            ).animate().fadeIn(duration: 1200.ms),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BlocBuilder<TimerCubit, TimerState>(
                                bloc: _timerCubit,
                                builder: (context, state) {
                                  if (state.totalSeconds > 0) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        state.formatted,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColor.blackText),
                                      ),
                                    );
                                  }
                                  if (state.isRunning == false) {
                                    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                                      bloc: _forgotPasswordCubit,
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (_otpController.text.isEmpty) {
                                              showSnackErrorMessage(context, 'Please Enter Code', 4);
                                              return;
                                            }
                                            if (state.status == ForgotPasswordStatus.sendingCode) return;
                                            _forgotPasswordCubit.verifyOTP(email: widget.email, code: _otpController.text);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                                            child:
                                                state.status == ForgotPasswordStatus.sendingCode
                                                    ? CircularProgressIndicator()
                                                    : Text(
                                                      'Resend',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        decoration: TextDecoration.underline,
                                                        color: AppColor.kBlack,
                                                      ),
                                                    ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                              bloc: _forgotPasswordCubit,
                              listener: (context, state) {
                                if (state.status == ForgotPasswordStatus.codeVerified) {
                                  showSnackMessage(context, "Code successfully  verified");
                                  NavigationService.push(ChangePasswordScreen(email: widget.email));
                                } else if (state.status == ForgotPasswordStatus.error) {
                                  showSnackErrorMessage(context, state.error, 4);
                                }
                              },
                              builder: (context, state) {
                                return CustomButton(
                                  onPressed: () {
                                    _forgotPasswordCubit.verifyOTP(email: widget.email, code: _otpController.text);
                                  },
                                  buttonTitle: "Verify",
                                  loading: state.status == ForgotPasswordStatus.verifyingCode,
                                  buttonColor: forgotPassConfig.buttonColor,
                                  textStyle: context.text15Medium?.copyWith(color: forgotPassConfig.buttonTextColor),
                                  borderRadius: 30,
                                );
                              },
                            ).animate().fadeIn(duration: 1400.ms).slideY(begin: 0.3, end: 0),
                          ),
                          SizedBox(height: 20),
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
