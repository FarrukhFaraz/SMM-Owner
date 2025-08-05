part of 'order_cubit.dart';

enum OrderStatus { initial, loading, success, saving, error }

class OrderState extends Equatable {
  final OrderStatus status;
  final String error;
  final CreateOrderModel? createOrderModel;
  final List<OrderModel> orderList;

  const OrderState({required this.status, required this.error, required this.orderList, this.createOrderModel});

  factory OrderState.initial() {
    return OrderState(status: OrderStatus.initial, error: '', orderList: [], createOrderModel: null);
  }

  OrderState copyWith({OrderStatus? status, String? error, List<OrderModel>? orderList, CreateOrderModel? createOrderModel}) {
    return OrderState(
      status: status ?? this.status,
      error: error ?? this.error,
      orderList: orderList ?? this.orderList,
      createOrderModel: createOrderModel ?? this.createOrderModel,
    );
  }

  @override
  List<Object?> get props => [status, error, orderList, createOrderModel];
}
