import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/presentation/wallet/screens/transaction_detail_screen.dart';

import '../cubit/wallet_cubit.dart';
import '../model/wallet_model.dart';
import '../util/currency_formatter.dart';
import '../widgets/transaction_item_widget.dart';
import '../widgets/transaction_list_empty.dart';
import '../widgets/transaction_list_error.dart';
import '../widgets/transaction_list_shimmer.dart';

class WalletTransactionListScreen extends StatefulWidget {
  const WalletTransactionListScreen({super.key});

  @override
  State<WalletTransactionListScreen> createState() => _WalletTransactionListScreenState();
}

class _WalletTransactionListScreenState extends State<WalletTransactionListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Deposit', 'Withdraw', 'Transfer'];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);

    // Fetch transactions on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WalletCubit>().fetchTransactions();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedFilter = _tabs[_tabController.index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        floatHeaderSlivers: true,

        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(

              title: const Text('Wallet Transactions', style: TextStyle(fontWeight: FontWeight.w600)),
              centerTitle: true,
              pinned: true,
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: _showFilterBottomSheet)],
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _SliverAppBarDelegate(
                  child: Container(

                  
                  color: Colors.white, child: Column(children: [_buildSummaryCards(), _buildTabBar()]))),
            ),
          ];
        },
        body: BlocConsumer<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(label: 'Retry', textColor: Colors.white, onPressed: () => context.read<WalletCubit>().retryFetch()),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const TransactionListShimmer();
            }

            if (state.hasError && !state.hasData) {
              return TransactionListError(
                message: state.errorMessage ?? 'Unknown error occurred',
                onRetry: () => context.read<WalletCubit>().retryFetch(),
              );
            }

            if (state.isEmpty) {
              return TransactionListEmpty(onRefresh: () => context.read<WalletCubit>().refreshTransactions());
            }

            final filteredTransactions = _getFilteredTransactions(state.transactions);

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<WalletCubit>().refreshTransactions();
              },
              child:
                  filteredTransactions.isEmpty
                      ? _buildEmptyFilterResult()
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = filteredTransactions[index];
                          return TransactionListItem(transaction: transaction, onTap: () => _navigateToDetail(transaction));
                        },
                      ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (!state.hasData) return const SizedBox.shrink();

        final cubit = context.read<WalletCubit>();
        final totalCredit = cubit.getTotalAmount(type: 'deposit');
        final totalDebit = cubit.getTotalAmount(type: 'withdraw');
        final totalTransfer = cubit.getTotalAmount(type: 'deduct');

        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: _buildSummaryCard('Total Credit', CurrencyFormatter.format(totalCredit, 'USD'), Colors.green, Icons.arrow_downward)),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Total Debit', CurrencyFormatter.format(totalDebit, 'USD'), Colors.red, Icons.arrow_upward)),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Transfer',
                  CurrencyFormatter.format(totalTransfer, 'USD'),
                  totalTransfer >= 0 ? Colors.blue : Colors.orange,
                  Icons.account_balance_wallet,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(Icons.trending_up, color: color, size: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),),
              const SizedBox(height: 4),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Theme.of(context).primaryColor,
        labelColor: Theme.of(context).primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  List<WalletTransactionModel> _getFilteredTransactions(List<WalletTransactionModel> transactions) {
    if (_selectedFilter == 'All') return transactions;

    return transactions.where((transaction) {
      final type = transaction.type?.toLowerCase() ?? '';
      switch (_selectedFilter.toLowerCase()) {
        case 'deposit':
          return type.contains('deposit') || type.contains('credit');
        case 'withdraw':
          return type.contains('withdraw') || type.contains('debit');
        case 'transfer':
          return type.contains('transfer') || type.contains('deduct');
        default:
          return true;
      }
    }).toList();
  }

  Widget _buildEmptyFilterResult() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_list_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('No $_selectedFilter Transactions', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700])),
            const SizedBox(height: 8),
            Text(
              'Try selecting a different filter or check back later.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter Transactions', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Date Range'),
                  subtitle: const Text('Filter by custom date range'),
                  leading: const Icon(Icons.date_range),
                  onTap: () {
                    Navigator.pop(context);
                    _showDateRangePicker();
                  },
                ),
                // ListTile(
                //   title: const Text('Amount Range'),
                //   subtitle: const Text('Filter by transaction amount'),
                //   leading: const Icon(Icons.money),
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // _showAmountFilter();
                //   },
                // ),
                ListTile(
                  title: const Text('Transaction Status'),
                  subtitle: const Text('Filter by completion status'),
                  leading: const Icon(Icons.check_circle),
                  onTap: () {
                    Navigator.pop(context);
                    _showStatusFilter();
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(primary: Theme.of(context).primaryColor)),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final cubit = context.read<WalletCubit>();
      final filteredTransactions = cubit.getTransactionsByDateRange(startDate: picked.start, endDate: picked.end);

      // Show results in a dialog or navigate to filtered view
      _showFilterResults('Date Range', filteredTransactions);
    }
  }

  // void _showAmountFilter() {
  //   // Implementation for amount range filter
  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog(
  //           title: const Text('Amount Filter'),
  //           content: const Text('Amount filtering feature coming soon!'),
  //           actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
  //         ),
  //   );
  // }

  void _showStatusFilter() {
    final statuses = ['completed', 'pending', 'failed', 'rejected'];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Filter by Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  statuses
                      .map(
                        (status) => ListTile(
                          title: Text(status.toUpperCase()),
                          onTap: () {
                            Navigator.pop(context);
                            final cubit = context.read<WalletCubit>();
                            final filteredTransactions = cubit.getTransactionsByStatus(status);
                            _showFilterResults('Status: ${status.toUpperCase()}', filteredTransactions);
                          },
                        ),
                      )
                      .toList(),
            ),
          ),
    );
  }

  void _showFilterResults(String filterName, List<WalletTransactionModel> transactions) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('$filterName Results'),
            content: Text('Found ${transactions.length} transactions'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
          ),
    );
  }

  void _navigateToDetail(WalletTransactionModel transaction) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDetailScreen(transaction: transaction)));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 180;

  @override
  double get maxExtent => 200;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
