part of 'wallet_cubit.dart';

enum WalletStatus { initial, loading, success, error, refreshing }

class WalletState extends Equatable {
  final WalletStatus status;
  final List<WalletTransactionModel> transactions;
  final String? errorMessage;

  const WalletState({required this.status, required this.transactions, this.errorMessage});

  factory WalletState.initial() {
    return const WalletState(status: WalletStatus.initial, transactions: [], errorMessage: null);
  }

  WalletState copyWith({WalletStatus? status, List<WalletTransactionModel>? transactions, String? errorMessage}) {
    return WalletState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, transactions, errorMessage];

  bool get isLoading => status == WalletStatus.loading;

  bool get isRefreshing => status == WalletStatus.refreshing;

  bool get hasError => status == WalletStatus.error;

  bool get hasData => transactions.isNotEmpty;

  bool get isEmpty => transactions.isEmpty && status == WalletStatus.success;
}
