import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/service/model/service_model.dart';
import 'package:sms_owner/presentation/service/repository/service_repository.dart';

part 'service_category_state.dart';

class ServiceCategoryCubit extends Cubit<ServiceCategoryState> {
  ServiceCategoryCubit() : super(ServiceCategoryState.initial());

  Future<void> fetchAllCategory() async {
      emit(state.copyWith(status: ServiceCategoryStatus.loading));

    try {
      List<ServiceCategoryModel> categoryList = await ServiceRepository().fetchCategory();

      emit(state.copyWith(status: ServiceCategoryStatus.success, categoryList: categoryList));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('ServiceCategoryCubit.fetchAllCategory:::: ${e.message}');
      }
      emit(state.copyWith(status: ServiceCategoryStatus.error, message: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('ServiceCategoryCubit.fetchAllCategory::::');
      }
      emit(state.copyWith(status: ServiceCategoryStatus.error, message: e.toString()));
    }
  }
}
