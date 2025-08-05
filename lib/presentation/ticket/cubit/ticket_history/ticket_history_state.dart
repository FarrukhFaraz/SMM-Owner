part of 'ticket_history_cubit.dart';

enum TicketHistoryStatus { initial, loading, success, error }

class TicketHistoryState extends Equatable {
  final TicketHistoryStatus status;
  final String error;
  final List<TicketHistoryModel> ticketsList;

  const TicketHistoryState({required this.status, required this.error, required this.ticketsList});

  factory TicketHistoryState.initial() {
    return TicketHistoryState(status: TicketHistoryStatus.initial, error: '', ticketsList: []);
  }

  TicketHistoryState copyWith({TicketHistoryStatus? status, String? error, List<TicketHistoryModel>? ticketsList}) {
    return TicketHistoryState(status: status ?? this.status, error: error ?? this.error, ticketsList: ticketsList ?? this.ticketsList);
  }

  @override
  List<Object?> get props => [status, error, ticketsList];
}
