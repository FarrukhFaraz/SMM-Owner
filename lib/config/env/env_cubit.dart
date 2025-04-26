import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'env_model.dart';
import 'env.dart';

class EnvCubit extends Cubit<ENVModel> {
  EnvCubit() : super(ENVModel.fromEnvironment(environment));

  void updateEnv() async {
    try {
      final response = await DioClient().get('/app-config');
      if (kDebugMode) {
        print('EnvCubit.updateEnv');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        ENVModel responseModel = ENVModel.fromEnvironment(response.data);
        if (kDebugMode) {
          print('EnvCubit.updateEnv::::$responseModel');
        }
        emit(responseModel);
      }
    } on DioException catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }
    } on TypeError catch (e) {
      if (kDebugMode) {
        print(e.stackTrace);
      }
    } catch (e) {
      if (kDebugMode) {
        print('EnvCubit.updateEnv');
      }
    }
  }
}
