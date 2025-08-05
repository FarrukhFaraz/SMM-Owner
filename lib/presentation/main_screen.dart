import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/presentation/payments/screens/payments_screen.dart';
import 'package:sms_owner/presentation/profile/cubit/profile_cubit.dart';
import 'package:sms_owner/presentation/profile/screens/profile_screen.dart';

import 'home/home_screen.dart';
import 'order/screens/create_order_screen.dart';
import 'order/screens/order_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = context.read<ProfileCubit>();
    _profileCubit.fetchUserProfile();
  }

  int _selectedIndex = 0;
  int _currentIndex = 0;


  final List<Widget> _pages = const [
    HomeScreen(),
    OrderScreen(),
    CreateOrderScreen(),
    PaymentScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedIndex = index;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D6B5F),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF2D6B5F),
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Orders",
          ),
          // BottomNavigationBarItem(
          //   icon: Padding(padding: const EdgeInsets.only(right: 50), child: Icon(Icons.shopping_bag)),
          //   label: "Orders".padRight(20),
          // ),
          BottomNavigationBarItem(icon: SizedBox.shrink(),label: ''),
          // BottomNavigationBarItem(
          //   icon: Padding(padding: const EdgeInsets.only(left: 50), child: Icon(Icons.attach_money)),
          //   label: "Top-Up".padLeft(20),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Top-Up",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(3),
          child: FloatingActionButton(
            onPressed: () {
              _onItemTapped(2);
            },
            elevation: 0,
            backgroundColor: Color(0xFF2D6B5F),
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: 40, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
