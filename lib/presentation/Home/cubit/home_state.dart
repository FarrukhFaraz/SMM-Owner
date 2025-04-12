part of 'home_cubit.dart';

enum HomeStateStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStateStatus status;
  final String error;

  const HomeState({required this.status, required this.error});

  factory HomeState.initial() {
    return HomeState(status: HomeStateStatus.initial, error: '');
  }

  HomeState copyWith({HomeStateStatus? status, String? error}) {
    return HomeState(status: status ?? this.status, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, error];
}
