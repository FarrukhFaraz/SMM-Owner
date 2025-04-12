import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/auth/sign_up/model/sign_up_response_model.dart';
import 'package:sms_owner/presentation/auth/sign_up/repository/sign_up_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());

  Future<void> signUp({
    required String name,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    try {
      SignUpResponseModel responseModel = await SignUpRepository().signUp(
        name: name,
        username: username,
        email: email,
        phone: phone,
        password: password,
      );
      if (kDebugMode) {
        print('SignUpCubit.signUp:::: ${responseModel.statuscode}');
      }

      emit(state.copyWith(status: SignUpStatus.success));
    } on ApiError catch (e) {
      emit(state.copyWith(status: SignUpStatus.error, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: SignUpStatus.error, error: e.toString()));
    }
  }
}
