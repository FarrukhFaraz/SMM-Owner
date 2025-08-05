import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/profile/model/update_profile_model.dart';
import 'package:sms_owner/presentation/profile/model/user_model.dart';
import 'package:sms_owner/presentation/profile/repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  Future<void> fetchUpdateProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      UpdateProfileModel updateProfile = await ProfileRepository().fetchUpdateProfile();

      emit(state.copyWith(status: ProfileStatus.success, updateProfile: updateProfile));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.fetchUpdateProfile:::: ${e.message}');
      }
      emit(state.copyWith(status: ProfileStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.fetchUpdateProfile::::');
      }
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }

  Future<void> fetchUserProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      UserModel userModel = await ProfileRepository().fetchUserProfile();

      emit(state.copyWith(status: ProfileStatus.success, userModel: userModel));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.fetchUserProfile:::: ${e.message}');
      }
      emit(state.copyWith(status: ProfileStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.fetchUserProfile::::');
      }
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> body) async {
    emit(state.copyWith(status: ProfileStatus.saveLoading));
    try {
      UserModel userModel = await ProfileRepository().updateUserProfile(body);
      state.updateProfile?.user = userModel;
      emit(state.copyWith(status: ProfileStatus.savedSuccess, updateProfile: state.updateProfile));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.updateUserProfile:::: ${e.message}');
      }
      emit(state.copyWith(status: ProfileStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('ProfileCubit.updateUserProfile::::');
      }
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }
}
