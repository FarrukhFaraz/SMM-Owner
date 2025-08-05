import 'package:flutter/material.dart';
import 'package:sms_owner/config/env/config_model/home_config.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/wallet/screens/transaction_list_screen.dart';

Widget customAppBar(HomeConfig homeConfig) {
  return Container(
    height: 56,
    padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
    child: Row(
      children: [
        Icon(Icons.menu, color: homeConfig.menuIconColor),
        SizedBox(width: 60),
        CircleAvatar(backgroundColor: Colors.grey),
        const SizedBox(width: 10),
        Text("Logo here", style: TextStyle(fontSize: 20, color: homeConfig.logoTextColor, fontWeight: FontWeight.bold)),
        const Spacer(),
        buildNotificationIcon(Icons.message_outlined, 13, homeConfig),
        const SizedBox(width: 10),
        buildNotificationIcon(Icons.notifications_active_rounded, 13, homeConfig),
      ],
    ),
  );
}

PreferredSizeWidget customAppBar2({String? title, Color? backgroundColor}) {
  return AppBar(
    backgroundColor: backgroundColor,
    leading: Icon(Icons.menu_rounded, color: Colors.white, size: 26,),
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(backgroundColor: Colors.grey),
        SizedBox(width: 10),
        Text("Logo here", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(width: 20)
      ],
    ),
    actions: [
      GestureDetector(
          onTap: (){
            NavigationService.push(WalletTransactionListScreen());
          },
          child: _buildNotificationIcon2(Icons.account_balance_wallet)),
      const SizedBox(width: 10),
      _buildNotificationIcon2(Icons.notifications_active_rounded, count: 13),
      const SizedBox(width: 16),
    ],
  );
}

Widget buildNotificationIcon(IconData icon, int count, HomeConfig homeConfig) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Icon(icon, color: homeConfig.notificationIconColor, size: 40),
      Positioned(
        right: -6,
        top: -6,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
          child: Text("$count", style: const TextStyle(fontSize: 8, color: Colors.black)),
        ),
      ),
    ],
  );
}

Widget _buildNotificationIcon2(IconData icon, {int? count}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Icon(icon, color: Colors.white, size: 26),
      if (count != null)
        Positioned(
          right: -6,
          top: -6,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
            child: Text("$count", style: const TextStyle(fontSize: 8, color: Colors.black)),
          ),
        ),
    ],
  );
}
