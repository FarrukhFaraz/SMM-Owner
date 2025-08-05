import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_error.dart';
import '../../../order/model/order_model.dart';
import '../../../order/repository/order_repository.dart';
import '../../repository/ticket_repository.dart';

part 'create_ticket_state.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit() : super(CreateTicketState.initial());

  Future<void> getOrders() async {
    emit(state.copyWith(status: CreateTicketStatus.loading));
    try {
      List<OrderModel> val = await OrderRepository().fetchUsersOrders();

      emit(state.copyWith(status: CreateTicketStatus.success, orderList: val));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.getOrders:::: ${e.message}');
      }
      emit(state.copyWith(status: CreateTicketStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.getOrders::::$e');
      }
      emit(state.copyWith(status: CreateTicketStatus.error, error: e.toString()));
    }
  }


  Future<void> createTicket(Map<String, dynamic> body) async {
    emit(state.copyWith(status: CreateTicketStatus.saveLoading));
    try {
      bool val = await TicketRepository().saveTickets(body: body);

      if(val==true) {
        emit(state.copyWith(status: CreateTicketStatus.saveSuccess));
      }else{
        emit(state.copyWith(status: CreateTicketStatus.error, error: 'Something went wrong'));
      }
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.DioException:::: ${e.message}');
      }
      emit(state.copyWith(status: CreateTicketStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.getOrders::::$e');
      }
      emit(state.copyWith(status: CreateTicketStatus.error, error: e.toString()));
    }
  }


}
