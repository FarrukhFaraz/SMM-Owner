import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/presentation/wallet/model/wallet_model.dart';

import '../repository/transaction_repo.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletState.initial());

  Future<void> fetchTransactions({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        emit(state.copyWith(status: WalletStatus.refreshing));
      } else {
        emit(state.copyWith(status: WalletStatus.loading, errorMessage: null));
      }

      final transactions = await TransactionRepository().getUserTransactions();

      emit(state.copyWith(status: WalletStatus.success, transactions: transactions, errorMessage: null));
    } on ApiError catch (e) {
      emit(state.copyWith(status: WalletStatus.error, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: WalletStatus.error, errorMessage: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> refreshTransactions() async {
    await fetchTransactions(isRefresh: true);
  }

  void retryFetch() {
    fetchTransactions();
  }

  // Filter methods for advanced functionality
  List<WalletTransactionModel> getTransactionsByType(String type) {
    return state.transactions.where((t) => t.type == type).toList();
  }

  List<WalletTransactionModel> getTransactionsByStatus(String status) {
    return state.transactions.where((t) => t.status == status).toList();
  }

  List<WalletTransactionModel> getTransactionsByDateRange({required DateTime startDate, required DateTime endDate}) {
    return state.transactions.where((transaction) {
      if (transaction.createdAt == null) return false;

      try {
        final transactionDate = DateTime.parse(transaction.createdAt!);
        return transactionDate.isAfter(startDate) && transactionDate.isBefore(endDate.add(const Duration(days: 1)));
      } catch (e) {
        return false;
      }
    }).toList();
  }

  double getTotalAmount({String? status, String? type}) {
    var filteredTransactions = state.transactions;

    if (status != null) {
      filteredTransactions = filteredTransactions.where((t) => t.status == status).toList();
    }

    if (type != null) {
      filteredTransactions = filteredTransactions.where((t) => t.type?.toLowerCase() == type.toLowerCase()).toList();
    }

    return filteredTransactions.fold(0.0, (sum, transaction) => sum + (transaction.amount ?? 0.0));
  }

  void clearError() {
    if (state.hasError) {
      emit(state.copyWith(status: state.hasData ? WalletStatus.success : WalletStatus.initial, errorMessage: null));
    }
  }
}
