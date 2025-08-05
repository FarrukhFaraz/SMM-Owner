import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/wallet_model.dart';
import '../util/currency_formatter.dart';
import '../util/date_formatter.dart';
import '../util/download_feature.dart';
import '../util/share_service.dart';

class TransactionDetailScreen extends StatefulWidget {
  final WalletTransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  State<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _issueController = TextEditingController();
  final GlobalKey _screenshotKey = GlobalKey();
  final ScreenshotService _screenshotService = ScreenshotService();
  final ShareService _shareService = ShareService();


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: RepaintBoundary(
        key: _screenshotKey,
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      _buildTransactionSummary(),
                      const SizedBox(height: 16),
                      _buildDetailsSection(),
                      const SizedBox(height: 16),
                      _buildFinancialDetails(),
                      const SizedBox(height: 16),
                      _buildSystemDetails(),
                      const SizedBox(height: 16),
                      _buildActionButtons(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: _getStatusColor(),
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(_getTransactionTitle(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white)),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_getStatusColor(), _getStatusColor().withOpacity(0.8)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                // const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: Icon(_getTransactionIcon(), size: 48, color: Colors.white),
                ),
                Text(
                  CurrencyFormatter.format(widget.transaction.amount ?? 0.0, widget.transaction.currency ?? 'USD'),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share), onPressed: _shareAsImage),
        PopupMenuButton<String>(
          onSelected: _handleMenuAction,
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'copy_id',
                  child: ListTile(leading: Icon(Icons.copy), title: Text('Copy Transaction ID'), contentPadding: EdgeInsets.zero),
                ),
                const PopupMenuItem(
                  value: 'report',
                  child: ListTile(leading: Icon(Icons.report_problem), title: Text('Report Issue'), contentPadding: EdgeInsets.zero),
                ),
              ],
        ),
      ],
    );
  }

  Widget _buildTransactionSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Transaction Status', style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _getStatusColor().withOpacity(0.3)),
                    ),
                    child: Text(
                      widget.transaction.status?.toUpperCase() ?? 'UNKNOWN',
                      style: TextStyle(color: _getStatusColor(), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Date & Time', style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(
                    DateFormatter.formatTransactionDateTime(widget.transaction.createdAt),
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          if (widget.transaction.memo != null && widget.transaction.memo!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text('Description', style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(widget.transaction.memo!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return _buildSection(
      title: 'Transaction Details',
      icon: Icons.receipt_long,
      children: [
        _buildDetailRow('Transaction ID', widget.transaction.id?.toString() ?? 'N/A'),
        _buildDetailRow('Domain ID', widget.transaction.domainId?.toString() ?? 'N/A'),
        _buildDetailRow('User ID', widget.transaction.userId?.toString() ?? 'N/A'),
        if (widget.transaction.receiverId != null) _buildDetailRow('Receiver ID', widget.transaction.receiverId.toString()),
        _buildDetailRow('Type', _getTransactionTitle()),
        _buildDetailRow('Source Type', widget.transaction.sourceType ?? 'N/A'),
        if (widget.transaction.sourceId != null) _buildDetailRow('Source ID', widget.transaction.sourceId.toString()),
      ],
    );
  }

  Widget _buildFinancialDetails() {
    return _buildSection(
      title: 'Financial Information',
      icon: Icons.account_balance_wallet,
      children: [
        _buildDetailRow(
          'Amount',
          CurrencyFormatter.format(widget.transaction.amount ?? 0.0, widget.transaction.currency ?? 'USD'),
          isHighlighted: true,
        ),
        if (widget.transaction.bonusAmount != null && widget.transaction.bonusAmount! > 0)
          _buildDetailRow('Bonus Amount', CurrencyFormatter.format(widget.transaction.bonusAmount!.toDouble(), 'USD'), textColor: Colors.green[600]),
        if (widget.transaction.taxAmount != null && widget.transaction.taxAmount! > 0) ...[
          _buildDetailRow('Tax Amount', CurrencyFormatter.format(widget.transaction.taxAmount!.toDouble(), 'USD'), textColor: Colors.red[600]),
          _buildDetailRow('Tax Percentage', '${widget.transaction.taxPercent ?? 0}%'),
        ],
        _buildDetailRow('Currency', widget.transaction.currency ?? 'USD'),
        if (widget.transaction.exchangeRate != null) _buildDetailRow('Exchange Rate', widget.transaction.exchangeRate!),
        if (widget.transaction.amountUsd != null) _buildDetailRow('Amount (USD)', CurrencyFormatter.format(widget.transaction.amountUsd!, 'USD')),
        if (widget.transaction.balanceBefore != null)
          _buildDetailRow('Balance Before', CurrencyFormatter.format(widget.transaction.balanceBefore!, 'USD')),
        if (widget.transaction.balanceAfter != null)
          _buildDetailRow('Balance After', CurrencyFormatter.format(widget.transaction.balanceAfter!, 'USD')),
      ],
    );
  }

  Widget _buildSystemDetails() {
    return _buildSection(
      title: 'System Information',
      icon: Icons.settings,
      children: [
        _buildDetailRow('Created At', DateFormatter.formatTransactionDateTime(widget.transaction.createdAt)),
        _buildDetailRow('Updated At', DateFormatter.formatTransactionDateTime(widget.transaction.updatedAt)),
        _buildDetailRow('Viewed', widget.transaction.isViewed == true ? 'Yes' : 'No'),
        if (widget.transaction.rejectCount != null && widget.transaction.rejectCount! > 0)
          _buildDetailRow('Reject Count', widget.transaction.rejectCount.toString()),
        if (widget.transaction.permaReject == true) _buildDetailRow('Permanently Rejected', 'Yes', textColor: Colors.red),
        if (widget.transaction.transactionId != null) _buildDetailRow('External Transaction ID', widget.transaction.transactionId.toString()),
        if (widget.transaction.paymentMethodId != null) _buildDetailRow('Payment Method ID', widget.transaction.paymentMethodId.toString()),
      ],
    );
  }

  Widget _buildSection({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(20), child: Column(children: children)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlighted = false, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500))),
          Expanded(
            flex: 3,
            child: Container(
              padding: isHighlighted ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : null,
              decoration:
                  isHighlighted
                      ? BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8))
                      : null,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: isHighlighted ? 16 : 14,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
                  color: textColor ?? (isHighlighted ? Theme.of(context).primaryColor : Colors.black87),
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _downloadScreenshot,
              icon: const Icon(Icons.download),
              label: const Text('Download Receipt'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _contactSupport,
              icon: const Icon(Icons.support_agent),
              label: const Text('Contact Support'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  Color _getStatusColor() {
    switch (widget.transaction.status?.toLowerCase()) {
      case 'completed':
      case 'success':
        return Theme.of(context).primaryColor;
      case 'pending':
        return Colors.orange;
      case 'failed':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getTransactionIcon() {
    switch (widget.transaction.type?.toLowerCase()) {
      case 'deposit':
      case 'credit':
        return Icons.arrow_downward;
      case 'withdraw':
      case 'debit':
        return Icons.arrow_upward;
      case 'transfer':
        return Icons.swap_horiz;
      default:
        return Icons.payment;
    }
  }

  String _getTransactionTitle() {
    if (widget.transaction.type != null) {
      return widget.transaction.type!.split('_').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
    }
    return 'Transaction';
  }



  void _shareAsImage() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preparing image...')),
      );

      String? imagePath = await _screenshotService.captureForSharing(
          _screenshotKey,
          'transaction_detail'
      );

      if (imagePath != null) {
        await _shareService.shareTransactionImage(imagePath, widget.transaction);
      } else {
        throw Exception('Failed to capture screenshot');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing image: $e')),
      );
    }
  }


  void _handleMenuAction(String action) {
    switch (action) {
      case 'copy_id':
        if (widget.transaction.id != null) {
          Clipboard.setData(ClipboardData(text: widget.transaction.id.toString()));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaction ID copied to clipboard')));
        }
        break;
      case 'report':
        _reportIssueDialog();
        break;
    }
  }


  void _downloadScreenshot() async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 16),
              Text('Downloading screenshot...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      bool success = await _screenshotService.captureAndDownload(
          _screenshotKey,
          'transaction_${widget.transaction.id ?? 'detail'}'
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 16),
                Text('Screenshot saved to gallery!'),
              ],
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 16),
                Text('Failed to save screenshot. Please check permissions.'),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error capturing screenshot: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _contactSupport() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Contact Support'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email Support'),
                  subtitle: const Text('support@example.com'),
                  onTap: () {
                    _launchEmail();
                    Navigator.pop(context);
                    // Implement email functionality
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Call Support'),
                  subtitle: const Text('+1 (555) 123-4567'),
                  onTap: () {
                    _launchPhone();
                    Navigator.pop(context);
                    // Implement phone call functionality
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text('Live Chat'),
                  subtitle: const Text('Start a live chat session'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement chat functionality
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _reportIssueDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Report Issue'),
            content: const Text('This feature will allow you to report issues with this transaction.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _reportIssue();
                },
                child: const Text('Report'),
              ),
            ],
          ),
    );
  }

  // Email launcher method
  Future<void> _launchEmail() async {
    final transactionId = widget.transaction.id?.toString() ?? 'N/A';
    final transactionType = _getTransactionTitle();
    final amount = CurrencyFormatter.format(
        widget.transaction.amount ?? 0.0,
        widget.transaction.currency ?? 'USD'
    );

    final subject = Uri.encodeComponent('Support Request - Transaction $transactionId');
    final body = Uri.encodeComponent('''
Hello Support Team,

I need assistance with the following transaction:

Transaction ID: $transactionId
Type: $transactionType
Amount: $amount
Status: ${widget.transaction.status?.toUpperCase() ?? 'N/A'}
Date: ${DateFormatter.formatTransactionDateTime(widget.transaction.createdAt)}

Please describe your issue below:


Best regards,
[Your Name]
    ''');

    final emailUri = Uri.parse('mailto:support@example.com?subject=$subject&body=$body');

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Fallback: copy email details to clipboard
        await Clipboard.setData(ClipboardData(
            text: 'Email: support@example.com\n\nSubject: Support Request - Transaction $transactionId\n\n${Uri.decodeComponent(body)}'
        ));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email app not available. Email details copied to clipboard.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch email app: $e')),
        );
      }
    }
  }

  // Phone dialer launcher method
  Future<void> _launchPhone() async {
    const phoneNumber = '+15551234567'; // Remove spaces and format for tel: scheme
    final phoneUri = Uri.parse('tel:$phoneNumber');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        // Fallback: copy phone number to clipboard
        await Clipboard.setData(const ClipboardData(text: '+1 (555) 123-4567'));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Phone app not available. Phone number copied to clipboard.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch phone app: $e')),
        );
      }
    }
  }

  // Enhanced report issue method with form
  void _reportIssue() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Issue'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction ID: ${widget.transaction.id?.toString() ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please describe the issue:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _issueController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Describe the problem you encountered...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Issue categories:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildIssueChip('Incorrect Amount'),
                  _buildIssueChip('Wrong Status'),
                  _buildIssueChip('Missing Transaction'),
                  _buildIssueChip('Duplicate Transaction'),
                  _buildIssueChip('Other'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _issueController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _submitIssueReport();
              Navigator.pop(context);
            },
            child: const Text('Submit Report'),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueChip(String label) {
    return FilterChip(
      label: Text(label),
      onSelected: (selected) {
        if (selected) {
          // Add the selected category to the issue description
          final currentText = _issueController.text;
          final newText = currentText.isEmpty
              ? 'Category: $label\n\n'
              : '$currentText\nCategory: $label\n';
          _issueController.text = newText;
          _issueController.selection = TextSelection.fromPosition(
            TextPosition(offset: _issueController.text.length),
          );
        }
      },
    );
  }

  void _submitIssueReport() {
    final issueDescription = _issueController.text.trim();

    if (issueDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe the issue before submitting.')),
      );
      return;
    }

    // Here you would typically send the report to your backend
    // For now, we'll simulate the submission

    final reportData = {
      'transactionId': widget.transaction.id?.toString() ?? 'N/A',
      'userId': widget.transaction.userId?.toString() ?? 'N/A',
      'issueDescription': issueDescription,
      'transactionAmount': widget.transaction.amount?.toString() ?? '0',
      'transactionStatus': widget.transaction.status ?? 'unknown',
      'reportedAt': DateTime.now().toIso8601String(),
    };

    // TODO: Replace with actual API call
    // await _apiService.submitIssueReport(reportData);

    print('Issue Report Submitted: $reportData'); // For debugging

    _issueController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Issue report submitted successfully! We\'ll review it shortly.'),
        duration: Duration(seconds: 3),
      ),
    );

    // Optionally, you can also send an email with the report details
    _sendIssueReportEmail(reportData);
  }

  Future<void> _sendIssueReportEmail(Map<String, dynamic> reportData) async {
    final subject = Uri.encodeComponent('Issue Report - Transaction ${reportData['transactionId']}');
    final body = Uri.encodeComponent('''
Issue Report Details:

Transaction ID: ${reportData['transactionId']}
User ID: ${reportData['userId']}
Transaction Amount: ${reportData['transactionAmount']}
Transaction Status: ${reportData['transactionStatus']}
Reported At: ${reportData['reportedAt']}

Issue Description:
${reportData['issueDescription']}

---
This report was automatically generated from the mobile app.
    ''');

    final emailUri = Uri.parse('mailto:support@example.com?subject=$subject&body=$body');

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } catch (e) {
      // Silently handle email launch errors for issue reports
      print('Could not launch email for issue report: $e');
    }
  }

}
