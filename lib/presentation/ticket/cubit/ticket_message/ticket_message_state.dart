part of 'ticket_message_cubit.dart';

enum TicketMessageStatus { initial, loading, success, sending, sent, error }

class TicketMessageState extends Equatable {
  final TicketMessageStatus status;
  final String error;
  final List<TicketMessageModel> messageList;

  const TicketMessageState({required this.status, required this.error, required this.messageList});

  factory TicketMessageState.initial() {
    return TicketMessageState(status: TicketMessageStatus.initial, error: '', messageList: []);
  }

  TicketMessageState copyWith({TicketMessageStatus? status, String? error, List<TicketMessageModel>? messageList}) {
    return TicketMessageState(status: status ?? this.status, error: error ?? this.error, messageList: messageList ?? this.messageList);
  }

  @override
  List<Object?> get props => [status, error, messageList];
}
