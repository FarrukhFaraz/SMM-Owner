import 'package:flutter/material.dart';
import 'package:sms_owner/config/env/config_model/home_config.dart';

Widget customAppBar(HomeConfig homeConfig) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
    child: Row(
      children: [
        Icon(Icons.menu, color: homeConfig.menuIconColor),
        SizedBox(width: 60),
        CircleAvatar(backgroundColor: Colors.grey),
        const SizedBox(width: 10),
        Text(
          "Logo here",
          style: TextStyle(
            fontSize: 20,
            color: homeConfig.logoTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        buildNotificationIcon(Icons.verified, 13, homeConfig),
        const SizedBox(width: 10),
        buildNotificationIcon(Icons.notifications, 13, homeConfig),
      ],
    ),
  );
}

Widget buildNotificationIcon(IconData icon, int count, HomeConfig homeConfig) {
  return Stack(
    children: [
      Icon(icon, color: homeConfig.notificationIconColor),
      Positioned(
        right: 0,
        top: 0,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: Text(
            "$count",
            style: const TextStyle(fontSize: 10, color: Colors.black),
          ),
        ),
      ),
    ],
  );
}
