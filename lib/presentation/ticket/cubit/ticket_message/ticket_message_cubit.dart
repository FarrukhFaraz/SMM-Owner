import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/presentation/ticket/repository/ticket_repository.dart';

import '../../../../core/network/api_error.dart';
import '../../model/ticket_message_model.dart';

part 'ticket_message_state.dart';

class TicketMessageCubit extends Cubit<TicketMessageState> {
  TicketMessageCubit() : super(TicketMessageState.initial());

  Future<void> getTicketMessages(String ticketId) async {
    emit(state.copyWith(status: TicketMessageStatus.loading));
    try {
      List<TicketMessageModel> list = await TicketRepository().getTicketMessages(ticketId: ticketId);

      emit(state.copyWith(status: TicketMessageStatus.success, messageList: list));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.DioException:::: ${e.message}');
      }
      emit(state.copyWith(status: TicketMessageStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.getOrders::::$e');
      }
      emit(state.copyWith(status: TicketMessageStatus.error, error: e.toString()));
    }
  }

  Future<void> sendTicketMessages(Map<String, dynamic> body) async {
    emit(state.copyWith(status: TicketMessageStatus.sending));
    try {
      TicketMessageModel val = await TicketRepository().saveTicketMessage(body: body);

      emit(state.copyWith(status: TicketMessageStatus.sent,messageList: [...state.messageList, val]));
    } on ApiError catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.DioException:::: ${e.message}');
      }
      emit(state.copyWith(status: TicketMessageStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('CreateTicketCubit.getOrders::::$e');
      }
      emit(state.copyWith(status: TicketMessageStatus.error, error: e.toString()));
    }
  }

}
