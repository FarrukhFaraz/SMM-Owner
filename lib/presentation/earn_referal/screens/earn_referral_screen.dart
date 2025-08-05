import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sms_owner/config/theme/app_text_theme.dart';

import '../../../core/components/custom_appBar.dart';
import '../../../core/components/snack_message.dart';

class EarnReferralScreen extends StatefulWidget {
  const EarnReferralScreen({super.key});

  @override
  State<EarnReferralScreen> createState() => _EarnReferralScreenState();
}

class _EarnReferralScreenState extends State<EarnReferralScreen> {
  final List<Map<String, String>> earnings = [
    {"date": "2025-07-25", "user": "User123", "referral": "#REF001", "commission": "\$5.00", "status": "Pending"},
    {"date": "2025-07-24", "user": "User456", "referral": "#REF002", "commission": "\$10.00", "status": "Paid"},
    {"date": "2025-07-23", "user": "User789", "referral": "#REF003", "commission": "\$2.00", "status": "Rejected"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total earnings', style: context.text16Medium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Text('Share Link  ', style: context.text12Regular),
                GestureDetector(
                  onTap: () async {
                    final params = ShareParams(text: 'Great picture');

                    final result = await SharePlus.instance.share(params);
                  },
                  child: Icon(Icons.share, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Wrap(
              runAlignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildInfoCard(label: 'YOUR ORDER', value: '12345'),
                _buildInfoCard(label: 'SPEND BALANCE', value: '\$ 50000', valueColor: Colors.green),
                _buildInfoCard(label: 'CURRENT BALANCE', value: '\$ 50000', valueColor: Colors.green),
                _buildInfoCard(label: 'YOUR TICKET', value: '456789', valueColor: Color(0xff7d7d7d)),
              ],
            ),
            const SizedBox(height: 20),
            Text("My Referral link", style: context.text12Regular),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [
                  Expanded(child: Text("https://www.lifesite.com/api/v2", overflow: TextOverflow.ellipsis)),
                  GestureDetector(
                      onTap: ()async{
                        await FlutterClipboard.copy('https://www.lifesite.com/api/v2');
                        showSnackMessage(context, 'Link copied');
                      },
                      child: Icon(Icons.copy)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("Withdrawals", style: context.text12Regular),
            const SizedBox(height: 4),

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xfff9e4d9)),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      children: [
                        SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            'Date',
                            style: context.text12Bold?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            'User',
                            style: context.text12Bold?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            'Referral',
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
                              'Commission',
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
                  ),
                  const SizedBox(height: 6),
                  Container(height: 1.3, width: double.infinity, color: Colors.grey),
                  SizedBox(height: 8),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: earnings.length,
                    itemBuilder: (context, index){
                      final item = earnings[index];
                      return  Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Text(item['date']!)),
                            Expanded(flex: 2, child: Text(item['user']!)),
                            Expanded(flex: 2, child: Text(item['referral']!)),
                            Expanded(flex: 2, child: Text(item['commission']!)),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: _getStatusColor(item['status']!).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  item['status']!,
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _getStatusColor(item['status']!)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )

                ],
              ),
            ),


            ...earnings.map(
              (item) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(item['date']!)),
                    Expanded(flex: 2, child: Text(item['user']!)),
                    Expanded(flex: 2, child: Text(item['referral']!)),
                    Expanded(flex: 2, child: Text(item['commission']!)),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: _getStatusColor(item['status']!).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          item['status']!,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _getStatusColor(item['status']!)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildInfoCard({required String label, required String value, Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: context.text10Bold?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(value, style: context.text10Bold?.copyWith(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
