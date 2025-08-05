part of 'favorite_cubit.dart';


enum FavoriteStatus { initial, loading, success,error, saveLoading }

class FavoriteState extends Equatable {
  final FavoriteStatus status;
  final String message;
  final List<FavoriteModel> favoriteList;

  const FavoriteState({required this.status, required this.message, required this.favoriteList});

  factory FavoriteState.initial() {
    return FavoriteState(status: FavoriteStatus.initial, message: '', favoriteList: []);
  }

  FavoriteState copyWith({FavoriteStatus? status, String? message, List<FavoriteModel>? favoriteList}) {
    return FavoriteState(status: status ?? this.status, message: message ?? this.message, favoriteList: favoriteList ?? this.favoriteList);
  }

  @override
  List<Object?> get props => [status, message, favoriteList];
}
