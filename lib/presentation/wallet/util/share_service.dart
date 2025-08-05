import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../model/wallet_model.dart';
import '../util/currency_formatter.dart';
import '../util/date_formatter.dart';

class ShareService {
  static final ShareService _instance = ShareService._internal();

  factory ShareService() => _instance;

  ShareService._internal();

  /// Shares transaction details as text
  Future<void> shareTransactionText(WalletTransactionModel transaction) async {
    try {
      String transactionText = _formatTransactionText(transaction);

      await Share.share(transactionText, subject: 'Transaction Details - ${transaction.id}');
    } catch (e) {
      print('Error sharing transaction text: $e');
      rethrow;
    }
  }

  /// Shares transaction screenshot
  Future<void> shareTransactionImage(String imagePath, WalletTransactionModel transaction) async {
    try {
      File imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        throw Exception('Screenshot file not found');
      }

      String transactionText = _formatTransactionText(transaction);

      await Share.shareXFiles([XFile(imagePath)], text: transactionText, subject: 'Transaction Details - ${transaction.id}');
    } catch (e) {
      print('Error sharing transaction image: $e');
      rethrow;
    }
  }

  /// Shares both text and image
  Future<void> shareTransactionComplete(String imagePath, WalletTransactionModel transaction) async {
    try {
      await shareTransactionImage(imagePath, transaction);
    } catch (e) {
      print('Error sharing complete transaction: $e');
      // Fallback to text only
      await shareTransactionText(transaction);
    }
  }

  /// Shows a bottom sheet with sharing options
  Future<void> showShareOptions(BuildContext context, WalletTransactionModel transaction, {String? imagePath}) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ShareOptionsBottomSheet(transaction: transaction, imagePath: imagePath, shareService: this),
    );
  }

  /// Formats transaction data as readable text
  String _formatTransactionText(WalletTransactionModel transaction) {
    StringBuffer buffer = StringBuffer();

    buffer.writeln('💳 TRANSACTION DETAILS');
    buffer.writeln('=' * 30);
    buffer.writeln();

    // Basic Details
    buffer.writeln('📋 Basic Information:');
    buffer.writeln('• Transaction ID: ${transaction.id ?? 'N/A'}');
    buffer.writeln('• Type: ${_getTransactionTitle(transaction.type)}');
    buffer.writeln('• Status: ${transaction.status?.toUpperCase() ?? 'UNKNOWN'}');
    buffer.writeln('• Date: ${DateFormatter.formatTransactionDateTime(transaction.createdAt)}');
    buffer.writeln();

    // Financial Details
    buffer.writeln('💰 Financial Information:');
    buffer.writeln('• Amount: ${CurrencyFormatter.format(transaction.amount ?? 0.0, transaction.currency ?? 'USD')}');
    if (transaction.currency != null) {
      buffer.writeln('• Currency: ${transaction.currency}');
    }
    if (transaction.bonusAmount != null && transaction.bonusAmount! > 0) {
      buffer.writeln('• Bonus: ${CurrencyFormatter.format(transaction.bonusAmount!.toDouble(), 'USD')}');
    }
    if (transaction.taxAmount != null && transaction.taxAmount! > 0) {
      buffer.writeln('• Tax: ${CurrencyFormatter.format(transaction.taxAmount!.toDouble(), 'USD')} (${transaction.taxPercent ?? 0}%)');
    }
    if (transaction.amountUsd != null) {
      buffer.writeln('• Amount (USD): ${CurrencyFormatter.format(transaction.amountUsd!, 'USD')}');
    }
    buffer.writeln();

    // Balance Information
    if (transaction.balanceBefore != null || transaction.balanceAfter != null) {
      buffer.writeln('📊 Balance Information:');
      if (transaction.balanceBefore != null) {
        buffer.writeln('• Balance Before: ${CurrencyFormatter.format(transaction.balanceBefore!, 'USD')}');
      }
      if (transaction.balanceAfter != null) {
        buffer.writeln('• Balance After: ${CurrencyFormatter.format(transaction.balanceAfter!, 'USD')}');
      }
      buffer.writeln();
    }

    // Description
    if (transaction.memo != null && transaction.memo!.isNotEmpty) {
      buffer.writeln('📝 Description:');
      buffer.writeln('${transaction.memo}');
      buffer.writeln();
    }

    // System Details
    buffer.writeln('⚙️ System Information:');
    if (transaction.domainId != null) {
      buffer.writeln('• Domain ID: ${transaction.domainId}');
    }
    if (transaction.userId != null) {
      buffer.writeln('• User ID: ${transaction.userId}');
    }
    if (transaction.receiverId != null) {
      buffer.writeln('• Receiver ID: ${transaction.receiverId}');
    }
    if (transaction.sourceType != null) {
      buffer.writeln('• Source Type: ${transaction.sourceType}');
    }
    buffer.writeln();

    buffer.writeln('Generated on: ${DateFormatter.formatTransactionDateTime(DateTime.now().toString())}');
    buffer.writeln('Shared via Transaction Manager App');

    return buffer.toString();
  }

  String _getTransactionTitle(String? type) {
    if (type != null) {
      return type.split('_').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
    }
    return 'Transaction';
  }
}

class _ShareOptionsBottomSheet extends StatelessWidget {
  final WalletTransactionModel transaction;
  final String? imagePath;
  final ShareService shareService;

  const _ShareOptionsBottomSheet({required this.transaction, this.imagePath, required this.shareService});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.share, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                const Text('Share Transaction', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Share Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildShareOption(context, Icons.text_fields, 'Share as Text', 'Share transaction details as text', () async {
                  Navigator.pop(context);
                  try {
                    await shareService.shareTransactionText(transaction);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sharing text: $e')));
                  }
                }),

                if (imagePath != null) ...[
                  const SizedBox(height: 12),
                  _buildShareOption(context, Icons.image, 'Share as Image', 'Share transaction screenshot', () async {
                    Navigator.pop(context);
                    try {
                      await shareService.shareTransactionImage(imagePath!, transaction);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sharing image: $e')));
                    }
                  }),

                  const SizedBox(height: 12),
                  _buildShareOption(context, Icons.view_carousel, 'Share Complete', 'Share both image and text details', () async {
                    Navigator.pop(context);
                    try {
                      await shareService.shareTransactionComplete(imagePath!, transaction);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sharing: $e')));
                    }
                  }),
                ],
              ],
            ),
          ),

          // Cancel button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ),

          // Safe area padding
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildShareOption(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
