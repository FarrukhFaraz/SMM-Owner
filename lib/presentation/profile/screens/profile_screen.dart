import 'package:flutter/material.dart';
import 'package:sms_owner/core/components/custom_appBar.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/presentation/profile/screens/account_setting_screen.dart';
import 'package:sms_owner/presentation/ticket/screens/ticket_history_screen.dart';

import '../../api_settings/screens/api_setting_screen.dart';
import '../../earn_referal/screens/earn_referral_screen.dart';
import '../../favorite/screens/favorite_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar2(backgroundColor: Color(0xff00695c)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildNotificationCard(
                    icon: Icons.message,
                    label: 'Ticket Support',
                    count: 3,
                    color: Colors.orange,
                    backColors: [Color(0xffc2b7e6), Color(0xff785377)],
                    onTap: () {
                      NavigationService.push(TicketHistoryScreen());
                    },
                  ),
                  SizedBox(width: 50),
                  _buildNotificationCard(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    count: 3,
                    color: Colors.blue,
                    backColors: [Color(0xffc2b7e6), Color(0xff987fa2)],
                    onTap: () {},
                  ),
                  SizedBox(width: 50),
                  _buildNotificationCard(
                    icon: Icons.favorite_rounded,
                    label: 'Updates',
                    count: null,
                    color: Colors.white,
                    showHeart: true,
                    backColors: [Color(0xffa9c7c3), Color(0xff4c8479).withOpacity(0.2)],
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(height: 1.2, width: double.infinity, color: Color(0xffE5E5E5)),

            _buildMenuItem(
              title: 'My favorite list',
              onTap: () {
                NavigationService.push(MyFavoritesScreen());
              },
            ),
            _buildMenuItem(
              title: 'Ticket Support',
              badge: 3,
              onTap: () {
                NavigationService.push(TicketHistoryScreen());
              },
            ),
            _buildMenuItem(
              title: 'Earn & Referral',
              onTap: () {
                NavigationService.push(EarnReferralScreen());
              },
            ),
            _buildMenuItem(
              title: 'API',
              onTap: () {
                NavigationService.push(ApiSettingScreen());
              },
            ),
            _buildMenuItem(
              title: 'Account Setting',
              onTap: () {
                NavigationService.push(AccountSettingsScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String label,
    int? count,
    required Color color,
    bool showHeart = false,
    required List<Color> backColors,
    double size = 28,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 45,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(colors: backColors, begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child:
                      showHeart
                          ? Center(
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                              child: Icon(Icons.favorite, color: Colors.white, size: 16),
                            ),
                          )
                          : Icon(icon, color: color, size: size),
                ),
                if (count != null)
                  Positioned(
                    top: -10,
                    right: -10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Center(
                        child: Text(count.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required String title, int? badge, required VoidCallback onTap}) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1))),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500)),
        trailing:
            badge != null
                ? Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Center(
                    child: Text(badge.toString(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                )
                : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      ),
    );
  }
}
