part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, success, saveLoading, savedSuccess, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String error;
  final UpdateProfileModel? updateProfile;
  final UserModel? userModel;

  const ProfileState({required this.status, required this.error, this.updateProfile, this.userModel});

  factory ProfileState.initial() {
    return ProfileState(status: ProfileStatus.initial, error: '', updateProfile: null, userModel: null);
  }

  ProfileState copyWith({ProfileStatus? status, String? error, UpdateProfileModel? updateProfile, UserModel? userModel}) {
    return ProfileState(
      status: status ?? this.status,
      error: error ?? this.error,
      updateProfile: updateProfile ?? this.updateProfile,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [status, error, updateProfile, userModel];
}
