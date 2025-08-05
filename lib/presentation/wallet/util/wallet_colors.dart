import 'package:flutter/material.dart';
import 'package:sms_owner/presentation/wallet/util/date_formatter.dart';

class WalletColors {
  // Transaction Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color pendingOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
  static const Color infoBlue = Color(0xFF2196F3);

  // Transaction Type Colors
  static const Color creditGreen = Color(0xFF43A047);
  static const Color debitRed = Color(0xFFE53935);
  static const Color transferBlue = Color(0xFF1E88E5);
  static const Color paymentPurple = Color(0xFF8E24AA);

  // Background Colors
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color dividerGrey = Color(0xFFE0E0E0);

  // Text Colors
  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
  static const Color hintText = Color(0xFF9E9E9E);

  // Accent Colors
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color primaryBlueDark = Color(0xFF0D47A1);
  static const Color primaryBlueLight = Color(0xFF42A5F5);

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Status Color Methods
  static Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
      case 'success':
        return successGreen;
      case 'pending':
        return pendingOrange;
      case 'failed':
      case 'rejected':
        return errorRed;
      default:
        return Colors.grey;
    }
  }

  static Color getTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'deposit':
      case 'credit':
        return creditGreen;
      case 'withdraw':
      case 'debit':
        return debitRed;
      case 'transfer':
        return transferBlue;
      case 'payment':
        return paymentPurple;
      default:
        return Colors.grey;
    }
  }

  static String formatTransactionDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown Date';

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today • ${DateFormatter.timeOnlyFormat.format(date)}';
      } else if (difference.inDays == 1) {
        return 'Yesterday • ${DateFormatter.timeOnlyFormat.format(date)}';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago • ${DateFormatter.timeOnlyFormat.format(date)}';
      } else {
        return DateFormatter.transactionDateFormat.format(date);
      }
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
