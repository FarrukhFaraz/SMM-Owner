import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/favorite/model/favorite_model.dart';
import 'package:sms_owner/presentation/favorite/repository/favorite_repository.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState.initial());

  Future<void> fetchUserFavorite({showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(status: FavoriteStatus.loading));
    }
    try {
      List<FavoriteModel> favoriteList = await FavoriteRepository().fetchFavorites();

      emit(state.copyWith(status: FavoriteStatus.success, favoriteList: favoriteList));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite:::: ${e.message}');
      }
      emit(state.copyWith(status: FavoriteStatus.error, message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite::::');
      }
      emit(state.copyWith(status: FavoriteStatus.error, message: e.toString()));
    }
  }

  Future<bool> removeFromFavorite(String serviceId) async {
    emit(state.copyWith(status: FavoriteStatus.saveLoading));
    try {
      bool val = await FavoriteRepository().removeFromFavorite(serviceId);
      if (kDebugMode) {
        print('FavoriteCubit.removeFromFavorite::: $val');
      }
      if (val == true) {
        state.favoriteList.removeWhere((test) => test.serviceId.toString() == serviceId);
      }
      emit(state.copyWith(status: FavoriteStatus.success, favoriteList: state.favoriteList, message: 'Service removed from favorite'));
      return true;
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite:::: ${e.message}');
      }
      emit(state.copyWith(status: FavoriteStatus.error, message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite::::');
      }
      emit(state.copyWith(status: FavoriteStatus.error, message: e.toString()));
    }
    return false;
  }

  Future<bool> addToFavorite(String serviceId) async {
    emit(state.copyWith(status: FavoriteStatus.saveLoading));
    try {
      bool val = await FavoriteRepository().addToFavorite(serviceId);
      if (kDebugMode) {
        print('FavoriteCubit.removeFromFavorite::: $val');
      }
      fetchUserFavorite(showLoading: false);
      emit(state.copyWith(status: FavoriteStatus.success, message: 'Service added to favorite'));
      return true;
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite:::: ${e.message}');
      }
      emit(state.copyWith(status: FavoriteStatus.error, message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite::::');
      }
      emit(state.copyWith(status: FavoriteStatus.error, message: e.toString()));
    }
    return false;
  }
}
