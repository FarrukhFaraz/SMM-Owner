import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/auth/forgot_password/repository/forgot_password_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState.initial());

  Future<void> verifyEmail({required String email}) async {
    emit(state.copyWith(status: ForgotPasswordStatus.sendingCode));
    try {
      bool responseModel = await ForgotPasswordRepository().sendOTP(email: email);
      if (kDebugMode) {
        print('SignUpCubit.signUp:::: $responseModel');
      }

      emit(state.copyWith(status: ForgotPasswordStatus.codeSent));
    } on ApiError catch (e) {
      emit(state.copyWith(status: ForgotPasswordStatus.error, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: ForgotPasswordStatus.error, error: e.toString()));
    }
  }

  Future<void> verifyOTP({required String email, required String code}) async {
    emit(state.copyWith(status: ForgotPasswordStatus.verifyingCode));
    try {
      bool responseModel = await ForgotPasswordRepository().verifyOTP(email: email, otp: code);
      if (kDebugMode) {
        print('SignUpCubit.signUp:::: $responseModel');
      }

      emit(state.copyWith(status: ForgotPasswordStatus.codeVerified));
    } on ApiError catch (e) {
      emit(state.copyWith(status: ForgotPasswordStatus.error, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: ForgotPasswordStatus.error, error: e.toString()));
    }
  }

  Future<void> updatePassword({required String email, required String password}) async {
    emit(state.copyWith(status: ForgotPasswordStatus.updatingPassword));
    try {
      bool responseModel = await ForgotPasswordRepository().updatePassword(email: email, password: password);
      if (kDebugMode) {
        print('SignUpCubit.signUp:::: $responseModel');
      }

      emit(state.copyWith(status: ForgotPasswordStatus.passwordUpdated));
    } on ApiError catch (e) {
      emit(state.copyWith(status: ForgotPasswordStatus.error, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: ForgotPasswordStatus.error, error: e.toString()));
    }
  }
}
