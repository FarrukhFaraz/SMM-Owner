import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/auth/login/model/login_model.dart';
import 'package:sms_owner/presentation/auth/login/repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  Future<void> login({required String username, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      LoginResponseModel responseModel = await LoginRepository().login(username: username, password: password);
    } on ApiError catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e.toString()));
    }
  }
}
