

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/api_settings/model/api_setting_model.dart';
import 'package:sms_owner/presentation/api_settings/repository/api_setting_repository.dart';

part 'api_settings_state.dart';

class ApiSettingsCubit extends Cubit<ApiSettingsState> {
  ApiSettingsCubit() : super(ApiSettingsState.initial());

  Future<void> fetchAPISettings() async {
    emit(state.copyWith(status: APISettingsStatus.loading));
    try {
      List<ApiSettingModel> apiSettingList = await ApiSettingRepository().fetchAPISettings();

      emit(state.copyWith(status: APISettingsStatus.success, apiSettingList: apiSettingList));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.fetchUpdateProfile:::: ${e.message}');
      }
      emit(state.copyWith(status: APISettingsStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.fetchUpdateProfile::::');
      }
      emit(state.copyWith(status: APISettingsStatus.error, error: e.toString()));
    }
  }

}
