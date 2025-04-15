import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/storage/preferences.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/Home/model/user_profile_model.dart';
import 'package:sms_owner/presentation/Home/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  UserProfileModel? myProfile;

  Future<void> getMyProfile({bool loading = true}) async {
    if (loading) {
      emit(state.copyWith(status: HomeStateStatus.loading));
    }

    var id = await SecureStorageService.getString(CommonKeys.userId);
    if (id == null) return;
    try {
      UserProfileModel profile = await HomeRepository().getProfile(id: id);
      myProfile = profile;
      if (profile.name != null) SharedPreferenceService.setString("name", profile.name ?? "");
      if (profile.image != null) SharedPreferenceService.setString("PROFILE_IMAGE", profile.image ?? '');

      emit(state.copyWith(status: HomeStateStatus.success));
    } on ApiError catch (e) {
      print('HomeCubit.getMyProfile:::: $e');
      emit(state.copyWith(status: HomeStateStatus.error, error: e.message));
    } catch (e) {
      print('HomeCubit.getMyProfile::Exce:: $e');
      emit(state.copyWith(status: HomeStateStatus.error, error: e.toString()));
    }
  }
}
