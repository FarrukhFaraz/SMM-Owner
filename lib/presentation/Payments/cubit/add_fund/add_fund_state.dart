part of 'add_fund_cubit.dart';

enum AddFundStatus { initial, loading, success, error }

class AddFundState extends Equatable {
  final AddFundStatus status;
  final String error;

  const AddFundState({required this.status, required this.error});

  factory AddFundState.initial() {
    return AddFundState(status: AddFundStatus.initial, error: '');
  }

  AddFundState copyWith({AddFundStatus? status, String? error}) {
    return AddFundState(status: status ?? this.status, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, error];
}
