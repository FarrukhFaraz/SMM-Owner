import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/presentation/Payments/repository/fund_repository.dart';
import 'package:sms_owner/presentation/Payments/model/payment_history_model.dart';

part 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  PaymentHistoryCubit() : super(PaymentHistoryState.initial());

  Future<void> loadPaymentHistory() async {
    emit(state.copyWith(status: PaymentHistoryStatus.loading));
    try {
      List<PaymentHistoryModel> historyList = await FundsRepository().loadPaymentHistory();

      emit(state.copyWith(status: PaymentHistoryStatus.success, paymentHistory: historyList));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund:::: ${e.message}');
      }
      emit(state.copyWith(status: PaymentHistoryStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund::::');
      }
      emit(state.copyWith(status: PaymentHistoryStatus.error, error: e.toString()));
    }
  }
}
