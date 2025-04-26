import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/presentation/Payments/repository/fund_repository.dart';

part 'add_fund_state.dart';

class AddFundCubit extends Cubit<AddFundState> {
  AddFundCubit() : super(AddFundState.initial());

  Future<void> addFund({required int paymentId, required double amount}) async {
    emit(state.copyWith(status: AddFundStatus.loading));
    try {
      bool val = await FundsRepository().addFunds(paymentId: paymentId, amount: amount);
      if (kDebugMode) {
        print('AddFundCubit.addFund:::: $val');
      }

      emit(state.copyWith(status: AddFundStatus.success));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund:::: ${e.message}');
      }
      emit(state.copyWith(status: AddFundStatus.error, error: e.message));
    } catch (e) {
      if (kDebugMode) {
        print('AddFundCubit.addFund::::');
      }
      emit(state.copyWith(status: AddFundStatus.error, error: e.toString()));
    }
  }
}
