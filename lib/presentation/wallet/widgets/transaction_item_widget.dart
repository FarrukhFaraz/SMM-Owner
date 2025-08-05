

import 'package:flutter/material.dart';

import '../model/wallet_model.dart';
import '../util/currency_formatter.dart';
import '../util/date_formatter.dart';

class TransactionListItem extends StatelessWidget {
  final WalletTransactionModel transaction;
  final VoidCallback onTap;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildTransactionIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getTransactionTitle(),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              CurrencyFormatter.format(
                                transaction.amount ?? 0.0,
                                transaction.currency ?? 'USD',
                              ),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _getAmountColor(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                transaction.memo ??transaction.detail?? 'No description',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _buildStatusChip(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormatter.formatTransactionDateTime(transaction.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                  if (transaction.id != null)
                    Text(
                      'ID: ${transaction.id}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                        fontFamily: 'monospace',
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionIcon() {
    IconData iconData;
    Color iconColor;

    switch (transaction.type?.toLowerCase()) {
      case 'deposit':
      case 'credit':
        iconData = Icons.arrow_downward;
        iconColor = Colors.green;
        break;
      case 'withdraw':
      case 'debit':
        iconData = Icons.arrow_upward;
        iconColor = Colors.red;
        break;
      case 'transfer':
        iconData = Icons.swap_horiz;
        iconColor = Colors.blue;
        break;
      default:
        iconData = Icons.payment;
        iconColor = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    Color textColor;

    switch (transaction.status?.toLowerCase()) {
      case 'completed':
      case 'success':
        chipColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green[700]!;
        break;
      case 'pending':
        chipColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange[700]!;
        break;
      case 'failed':
      case 'rejected':
        chipColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red[700]!;
        break;
      default:
        chipColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        transaction.status?.toUpperCase() ?? 'UNKNOWN',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  String _getTransactionTitle() {
    if (transaction.type != null) {
      return transaction.type!.split('_').map((word) =>
      word[0].toUpperCase() + word.substring(1).toLowerCase()
      ).join(' ');
    }
    return 'Transaction';
  }

  Color _getAmountColor() {
    switch (transaction.type?.toLowerCase()) {
      case 'deposit':
      case 'credit':
        return Colors.green[600]!;
      case 'withdraw':
      case 'debit':
        return Colors.red[600]!;
      default:
        return Colors.grey[800]!;
    }
  }
}

