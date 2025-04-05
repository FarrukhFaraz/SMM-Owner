part of 'general_cubit.dart';

enum GeneralCubitStatus { initial, loading, success, error }

class GeneralState {
  GeneralCubitStatus? status;

  GeneralState({this.status});

  factory GeneralState.initial() {
    return GeneralState(status: GeneralCubitStatus.initial);
  }

  GeneralState copyWith({GeneralCubitStatus? status}) {
    return GeneralState(status: status ?? this.status);
  }
}
