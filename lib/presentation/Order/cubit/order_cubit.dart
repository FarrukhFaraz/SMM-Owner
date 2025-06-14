import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';

import 'package:sms_owner/presentation/Order/model/order_model.dart';
import 'package:sms_owner/presentation/Order/repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState.initial());

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      Map<String, dynamic> body = {
        "user_id": await SecureStorageService.getString(CommonKeys.userId),
      };
      List<OrderModel> val = await OrderRepository().fetchOrders(body);

      emit(state.copyWith(status: OrderStatus.success, orderList: val));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund:::: ${e.message}');
      }
      emit(state.copyWith(status: OrderStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund:::: $e');
      }
      emit(state.copyWith(status: OrderStatus.error, error: e.toString()));
    }
  }
}
