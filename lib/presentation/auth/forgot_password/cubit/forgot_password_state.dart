part of 'forgot_password_cubit.dart';

enum ForgotPasswordStatus { initial, sendingCode, verifyingCode, updatingPassword, codeSent, codeVerified, passwordUpdated, error }

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final String error;

  const ForgotPasswordState({required this.status, required this.error});

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(status: ForgotPasswordStatus.initial, error: '');
  }

  ForgotPasswordState copyWith({ForgotPasswordStatus? status, String? error}) {
    return ForgotPasswordState(status: status ?? this.status, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, error];
}
