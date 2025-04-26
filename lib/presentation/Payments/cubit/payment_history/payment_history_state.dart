part of 'payment_history_cubit.dart';

enum PaymentHistoryStatus { initial, loading, success, error }

class PaymentHistoryState extends Equatable {
  final PaymentHistoryStatus status;
  final String error;
  final List<PaymentHistoryModel> paymentHistory;

  const PaymentHistoryState({required this.status, required this.error, required this.paymentHistory});

  factory PaymentHistoryState.initial() {
    return PaymentHistoryState(status: PaymentHistoryStatus.initial, error: '', paymentHistory: []);
  }

  PaymentHistoryState copyWith({PaymentHistoryStatus? status, String? error, List<PaymentHistoryModel>? paymentHistory}) {
    return PaymentHistoryState(status: status ?? this.status, error: error ?? this.error, paymentHistory: paymentHistory ?? this.paymentHistory);
  }

  @override
  List<Object?> get props => [status, error, paymentHistory];
}
