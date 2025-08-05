part of 'create_ticket_cubit.dart';

enum CreateTicketStatus { initial, loading, success, saveLoading,saveSuccess, error }

class CreateTicketState extends Equatable {
  final CreateTicketStatus status;
  final String error;
  final List<OrderModel> orderList;

  const CreateTicketState({required this.status, required this.error, required this.orderList});

  factory CreateTicketState.initial() {
    return CreateTicketState(status: CreateTicketStatus.initial, error: '', orderList: []);
  }

  CreateTicketState copyWith({CreateTicketStatus? status, String? error, List<OrderModel>? orderList}) {
    return CreateTicketState(status: status ?? this.status, error: error ?? this.error, orderList: orderList ?? this.orderList);
  }

  @override
  List<Object?> get props => [status, error, orderList];
}

