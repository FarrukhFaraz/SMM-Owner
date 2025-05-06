import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/presentation/Payments/model/payment_model.dart';
import 'package:sms_owner/presentation/Payments/repository/fund_repository.dart';
part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodState.initial());

  Future<void> loadPaymentMethod() async {
    emit(state.copyWith(status: PaymentMethodStatus.loading));
    try {
      List<PaymentModel> val = await FundsRepository().loadPaymentMethods();

      emit(state.copyWith(status: PaymentMethodStatus.success, paymentList: val));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund:::: ${e.message}');
      }
      emit(state.copyWith(status: PaymentMethodStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund::::');
      }
      emit(state.copyWith(status: PaymentMethodStatus.error, error: e.toString()));
    }
  }
}
