import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/auth/login/model/login_model.dart';
import 'package:sms_owner/presentation/auth/login/repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  Future<void> login({required String username, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      LoginResponseModel responseModel = await LoginRepository().login(username: username, password: password);
      if (kDebugMode) {
        print('LoginCubit.login::::${responseModel.message}');
      }
      if (responseModel.user?.id != null) {
        SecureStorageService.setString(CommonKeys.userId, responseModel.user!.id!.toString());
      }
      if (responseModel.token != null) {
        DioClient().setToken(responseModel.token ?? '');
        SecureStorageService.setString(CommonKeys.accessToken, responseModel.token!.toString());
      }
      if (responseModel.user?.username != null) {
        SecureStorageService.setString(CommonKeys.name, responseModel.user!.name.toString());
      }

      emit(state.copyWith(status: LoginStatus.success));
    } on ApiError catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e.message));
    } on DioException {
      emit(state.copyWith(status: LoginStatus.error, error: 'Some thing went Wrong'));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e.toString()));
    }
  }
}
