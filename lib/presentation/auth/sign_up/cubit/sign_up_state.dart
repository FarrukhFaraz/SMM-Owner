part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, loading, success, error }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String error;

  const SignUpState({required this.status, required this.error});

  factory SignUpState.initial() {
    return SignUpState(status: SignUpStatus.initial, error: '');
  }

  SignUpState copyWith({SignUpStatus? status, String? error}) {
    return SignUpState(status: status ?? this.status, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, error];
}
