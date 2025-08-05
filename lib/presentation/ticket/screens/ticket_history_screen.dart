import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';
import 'package:sms_owner/core/components/custom_textField.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/ticket/cubit/ticket_history/ticket_history_cubit.dart';
import 'package:sms_owner/presentation/ticket/screens/create_ticket_screen.dart';
import 'package:sms_owner/presentation/ticket/screens/ticket_detail_screen.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_appBar.dart';
import '../model/ticket_history_model.dart';

class TicketHistoryScreen extends StatefulWidget {
  const TicketHistoryScreen({super.key});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TicketHistoryModel> filteredTickets = [];
  final List<TicketHistoryModel> tickets = [];

  late TicketHistoryCubit _ticketHistoryCubit;

  @override
  void initState() {
    super.initState();
    _ticketHistoryCubit = context.read<TicketHistoryCubit>();
    _ticketHistoryCubit.getTickets();
  }

  void _filterTickets() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredTickets = tickets;
      } else {
        filteredTickets =
            tickets
                .where(
                  (ticket) =>
                      (ticket.order?.service?.name).toString().toLowerCase().contains(_searchController.text.toLowerCase()) ||
                      (ticket.order?.systemMemo).toString().toLowerCase().contains(_searchController.text.toLowerCase()) ||
                      ticket.request.toString().contains(_searchController.text) ||
                      ticket.category.toString().contains(_searchController.text) ||
                      ticket.message.toString().contains(_searchController.text),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: BlocConsumer<TicketHistoryCubit, TicketHistoryState>(
        listener: (context, state) {
          if (state.status == TicketHistoryStatus.success) {
            filteredTickets.clear();
            tickets.clear();
            filteredTickets.addAll(state.ticketsList);
            tickets.addAll(state.ticketsList);
          }
        },
        builder: (context, state) {
          if (state.status == TicketHistoryStatus.loading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [Center(child: CircularProgressIndicator())],
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 16),
                Center(child: const Text('Ticket History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87))),
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    CustomButton(
                      buttonTitle: 'Create New Ticket',
                      onPressed: () {
                        NavigationService.push(CreateTicketScreen());
                      },
                      height: 36,
                      buttonColor: Colors.green,
                      width: 122,
                      textStyle: context.text12Medium?.copyWith(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ticketStatusWidget(state),

                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ticketStatusWidget(TicketHistoryState state) {
    if (state.ticketsList.isEmpty) {
      return Center(child: Text('No tickets created yet'));
    }
    return ticketsWidget();
  }

  Widget ticketsWidget() {
    return Column(
      children: [
        CustomTextField(
          controller: _searchController,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(60), borderSide: BorderSide(width: 1, color: CupertinoColors.systemGrey)),
          fillColor: Color(0xffebebeb),
          hintText: 'Search Order...',
          hintStyle: context.text12Regular?.copyWith(fontSize: 10),
          isDense: true,
          inputTextStyle: context.text12Regular?.copyWith(fontSize: 11),
          onChanged: (val) {
            _filterTickets();
          },
          prefix: SizedBox(width: 4),
          suffix: Padding(padding: const EdgeInsets.only(right: 8.0), child: Icon(Icons.search)),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xfff9e4d9)),
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 3),
                  SizedBox(
                    width: 12,
                    child: Text('ID', style: context.text12Bold?.copyWith(fontSize: 10, fontWeight: FontWeight.w600), textAlign: TextAlign.start),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Subject',
                      style: context.text12Bold?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      'Request',
                      style: context.text12Bold?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(width: 3),
                  // Expanded(
                  //   child: Center(
                  //     child: Text('ID', style: context.text12Bold?.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                  //   ),
                  // ),
                  // SizedBox(width: 3),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Update',
                        style: context.text12Bold?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(width: 3),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Status',
                        style: context.text12Bold?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Container(height: 1.3, width: double.infinity, color: Colors.grey),
              SizedBox(height: 4),
              if (filteredTickets.isEmpty) ...{
                Center(child: Text('No tickets found')),
              } else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredTickets.length,
                  itemBuilder: (context, index) {
                    final ticket = filteredTickets[index];
                    return _buildTableRow(ticket, index);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(TicketHistoryModel ticket, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(width: 3),
          SizedBox(width: 12, child: Text(ticket.id.toString(), style: context.text12Regular?.copyWith(fontSize: 10), textAlign: TextAlign.start)),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                NavigationService.push(TicketDetailScreen(model: ticket));
              },
              child: Text(
                ticket.subject ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.text12Regular?.copyWith(fontSize: 10, decoration: TextDecoration.underline, color: Colors.blue),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(width: 3),
          Expanded(child: Text(ticket.request ?? '', style: context.text12Regular?.copyWith(fontSize: 10), textAlign: TextAlign.start)),
          SizedBox(width: 3),
          Expanded(child: Text(getDate(ticket.updatedAt), style: context.text12Regular?.copyWith(fontSize: 10), textAlign: TextAlign.start)),
          SizedBox(width: 3),
          Expanded(child: _buildStatusChip(ticket.order?.status)),
        ],
      ),
    );
  }

  String getDate(DateTime? date) {
    if (date == null) return '';
    String formatted = '${DateFormat('dd-MMM-yy').format(date)}\n${DateFormat('hh-mm a').format(date)}';

    return formatted;
  }

  Widget _buildStatusChip(String? status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
      child: Text(
        status?.toUpperCase() ?? '',
        style: context.text12Regular?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 11),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
