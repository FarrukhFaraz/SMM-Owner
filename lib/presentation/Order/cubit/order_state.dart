part of 'order_cubit.dart';

enum OrderStatus { initial, loading, success, error }

class OrderState extends Equatable {
  final OrderStatus status;
  final String error;
  final List<OrderModel> orderList;

  const OrderState({required this.status, required this.error, required this.orderList});

  factory OrderState.initial() {
    return OrderState(status: OrderStatus.initial, error: '', orderList: []);
  }

  OrderState copyWith({OrderStatus? status, String? error, List<OrderModel>? orderList}) {
    return OrderState(status: status ?? this.status, error: error ?? this.error, orderList: orderList ?? this.orderList);
  }

  @override
  List<Object?> get props => [status, error, orderList];
}
