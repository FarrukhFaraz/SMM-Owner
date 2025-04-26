part of 'payment_method_cubit.dart';

enum PaymentMethodStatus { initial, loading, success, error }

class PaymentMethodState extends Equatable {
  final PaymentMethodStatus status;
  final String error;
  final List<PaymentModel> paymentList;

  const PaymentMethodState({required this.status, required this.error, required this.paymentList});

  factory PaymentMethodState.initial() {
    return PaymentMethodState(status: PaymentMethodStatus.initial, error: '', paymentList: []);
  }

  PaymentMethodState copyWith({PaymentMethodStatus? status, String? error, List<PaymentModel>? paymentList}) {
    return PaymentMethodState(status: status ?? this.status, error: error ?? this.error, paymentList: paymentList ?? this.paymentList);
  }

  @override
  List<Object?> get props => [status, error, paymentList];
}
