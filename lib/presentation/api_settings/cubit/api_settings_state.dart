part of 'api_settings_cubit.dart';

enum APISettingsStatus { initial, loading, success, saveLoading, savedSuccess, error }

class ApiSettingsState extends Equatable {
  final APISettingsStatus status;
  final String error;
  final List<ApiSettingModel> apiSettingList;

  const ApiSettingsState({required this.status, required this.error, required this.apiSettingList});

  factory ApiSettingsState.initial() {
    return ApiSettingsState(status: APISettingsStatus.initial, error: '', apiSettingList: []);
  }

  ApiSettingsState copyWith({APISettingsStatus? status, String? error, List<ApiSettingModel>? apiSettingList}) {
    return ApiSettingsState(status: status ?? this.status, error: error ?? this.error, apiSettingList: apiSettingList ?? this.apiSettingList);
  }

  @override
  List<Object?> get props => [status, error, apiSettingList];
}
