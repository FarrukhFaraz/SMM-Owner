import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sms_owner/core/utils/settings.dart';
import 'package:sms_owner/presentation/Home/cubit/home_cubit.dart';
import 'package:sms_owner/presentation/Home/home_screen.dart';
import 'package:sms_owner/presentation/Order/order_screen.dart';
import 'package:sms_owner/presentation/Payments/payments_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late HomeCubit _homeCubit;
  Settings settings = Settings();
  final PersistentTabController controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>();
    _homeCubit.getMyProfile(loading: _homeCubit.myProfile == null);
  }

  int _selectedIndex = 0;

  onItemTapped(int index) async {
    HapticFeedback.lightImpact();

    _selectedIndex = index;

    setState(() {});
  }

  bool keyboardVisible = false;

  final List<Widget> _pages = const [
    HomeScreen(),
    OrderScreen(),
    PaymentScreen(),
    Center(
      child: Text(
        "Account",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D6B5F),

      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF2D6B5F),
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Icon(Icons.shopping_bag),
            ),
            label: "Orders".padRight(20),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Icon(Icons.attach_money),
            ),
            label: "Top-Up".padLeft(20),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(3),
          child: FloatingActionButton(
            onPressed: () {},
            elevation: 0,
            backgroundColor: Color(0xFF2D6B5F),
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: 40),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
