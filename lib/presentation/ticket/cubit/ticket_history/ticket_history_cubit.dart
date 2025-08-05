import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:sms_owner/presentation/ticket/repository/ticket_repository.dart';

import '../../model/ticket_history_model.dart';

part 'ticket_history_state.dart';

class TicketHistoryCubit extends Cubit<TicketHistoryState> {
  TicketHistoryCubit() : super(TicketHistoryState.initial());

  Future<void> getTickets() async {
    emit(state.copyWith(status: TicketHistoryStatus.loading));
    try {
      List<TicketHistoryModel> val = await TicketRepository().getTickets();

      emit(state.copyWith(status: TicketHistoryStatus.success, ticketsList: val));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.getOrders:::: ${e.message}');
      }
      emit(state.copyWith(status: TicketHistoryStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.getOrders::::$e');
      }
      emit(state.copyWith(status: TicketHistoryStatus.error, error: e.toString()));
    }
  }


}
