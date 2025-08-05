import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/service/model/service_model.dart';
import 'package:sms_owner/presentation/service/repository/service_repository.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceState.initial());

  Future<void> fetchAllService(Map<String, dynamic> queryParam, {bool moreLoading = false}) async {
    if (moreLoading) {
      emit(state.copyWith(status: ServiceStatus.moreLoading));
    } else {
      emit(state.copyWith(status: ServiceStatus.loading));
    }
    try {
      ServiceResponseModel serviceResponseModel = await ServiceRepository().fetchAllService(queryParam);

      emit(state.copyWith(status: ServiceStatus.success, serviceResponseModel: serviceResponseModel));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite:::: ${e.message}');
      }
      emit(state.copyWith(status: ServiceStatus.error, message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite::::');
      }
      emit(state.copyWith(status: ServiceStatus.error, message: e.toString()));
    }
  }

  Future<void> fetchServicesByCategory(String categoryId) async {
    emit(state.copyWith(status: ServiceStatus.loading));

    try {
      ServiceResponseModel serviceResponseModel = await ServiceRepository().fetchServicesByCategory(categoryId);

      emit(state.copyWith(status: ServiceStatus.success, serviceResponseModel: serviceResponseModel));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite:::: ${e.message}');
      }
      emit(state.copyWith(status: ServiceStatus.error, message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('FavoriteCubit.fetchUserFavorite::::');
      }
      emit(state.copyWith(status: ServiceStatus.error, message: e.toString()));
    }
  }

}
