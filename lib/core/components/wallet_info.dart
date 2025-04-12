import 'package:flutter/material.dart';
import 'package:sms_owner/config/env/config_model/home_config.dart';

class WalletInfo extends StatelessWidget {
  final String title;
  final String value;
  final HomeConfig homeConfig;

  const WalletInfo({super.key, required this.title, required this.value, required this.homeConfig});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Icon(Icons.account_balance_wallet, color: homeConfig.walletIconColor, size: 30),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:  TextStyle(color: homeConfig.walletinfoTitleColor, fontSize: 16),
            ),
            Text(
              value,
              style:  TextStyle(
                color: homeConfig.walletInfoValueColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}