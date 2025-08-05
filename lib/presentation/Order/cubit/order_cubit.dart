import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/order/model/order_model.dart';
import 'package:sms_owner/presentation/order/repository/order_repository.dart';
import 'package:sms_owner/presentation/order/model/create_order_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState.initial());

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      List<OrderModel> val = await OrderRepository().fetchOrders();

      emit(state.copyWith(status: OrderStatus.success, orderList: val, createOrderModel: null));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund:::: ${e.message}');
      }
      emit(state.copyWith(status: OrderStatus.error, error: e.message, createOrderModel: null));
    } catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund::::');
      }
      emit(state.copyWith(status: OrderStatus.error, error: e.toString(), createOrderModel: null));
    }
  }


  Future<void> createOrder(Map<String, dynamic> data) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      CreateOrderModel? createOrderModel = await OrderRepository().createOrders(data);
      emit(state.copyWith(status: OrderStatus.success, createOrderModel: createOrderModel));
    } on ApiError catch (e) {
      Map<String, dynamic> data = jsonDecode(e.message ?? '');
      CreateOrderModel? createOrderModel = CreateOrderModel.fromJson(data);
      createOrderModel.statusCode = 404;
      emit(state.copyWith(status: OrderStatus.error, error: e.message, createOrderModel: createOrderModel));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.error, createOrderModel: CreateOrderModel(message: e.toString(), statusCode: 404)));
    }
  }
}
