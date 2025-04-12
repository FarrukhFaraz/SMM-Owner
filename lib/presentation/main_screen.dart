import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sms_owner/core/components/profile_pic_widget.dart';
import 'package:sms_owner/core/storage/preferences.dart';
import 'package:sms_owner/core/utils/app_color.dart';
import 'package:sms_owner/core/utils/settings.dart';
import 'package:sms_owner/presentation/Home/cubit/home_cubit.dart';
import 'package:sms_owner/presentation/Home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late HomeCubit _homeCubit;
  Settings settings = Settings();
  final PersistentTabController _controller = PersistentTabController();

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
    Center(child: Text("Orders", style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(child: Text("Top-Up", style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(child: Text("Account", style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    // double width = MediaQuery.of(context).size.width;
    // final bottomSpace = MediaQuery.of(context).viewPadding.bottom;
    // double kBottomNavBarHeight = kBottomNavigationBarHeight + bottomSpace;
    //
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(colors: [AppColor.kcPrimaryColor, AppColor.kcPrimaryDark], begin: Alignment.centerLeft, end: Alignment.centerRight),
    //   ),
    //   child: Stack(
    //     alignment: Alignment.bottomCenter,
    //     children: [
    //       PersistentTabView(
    //         controller: _controller,
    //         tabs: [
    //           PersistentTabConfig(
    //             screen: HomeScreen(),
    //             item: ItemConfig(icon: Icon(_selectedIndex != 0 ? Icons.home_outlined : Icons.home_filled, color: AppColor.kWhite, size: 30)),
    //           ),
    //           PersistentTabConfig(
    //             screen: Center(child: Text("Orders", style: TextStyle(color: Colors.white, fontSize: 24))),
    //
    //             item: ItemConfig(
    //               icon: Image(
    //                 image: AssetImage(_selectedIndex == 1 ? "assets/bottomBar/message-selected.png" : "assets/bottomBar/message.png"),
    //                 height: 30,
    //                 width: 30,
    //               ),
    //             ),
    //           ),
    //           PersistentTabConfig(
    //             screen: Center(child: Text('Create Screen')),
    //             item: ItemConfig(icon: Container(decoration: const BoxDecoration(color: Colors.transparent))),
    //           ),
    //           PersistentTabConfig(
    //             screen: Center(child: Text("Top-Up", style: TextStyle(color: Colors.white, fontSize: 24))),
    //             item: ItemConfig(
    //               icon: SvgPicture.asset(
    //                 _selectedIndex == 3 ? 'assets/icons/ic_bottom_nav_calendar.svg' : 'assets/icons/ic_bottom_nav_calendar_outlined.svg',
    //                 height: 23,
    //                 width: 25,
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //           ),
    //           PersistentTabConfig(
    //             screen: Center(child: Text("Account", style: TextStyle(color: Colors.white, fontSize: 24))),
    //             item: ItemConfig(
    //               icon: ProfilePicture(
    //                 boxFit: BoxFit.contain,
    //                 height: 25,
    //                 width: 25,
    //                 name: SharedPreferenceService.getString("name"),
    //                 profileUrl: context.watch<HomeCubit>().myProfile?.image ?? SharedPreferenceService.getString("PROFILE_IMAGE"),
    //               ),
    //             ),
    //           ),
    //         ],
    //         navBarBuilder:
    //             (navBarConfig) => settings.navBarBuilder(
    //               navBarConfig,
    //               NavBarDecoration(color: settings.navBarColor, borderRadius: BorderRadius.circular(10)),
    //               const ItemAnimation(),
    //               const NeumorphicProperties(),
    //             ),
    //
    //         backgroundColor: _selectedIndex == 2 ? Colors.transparent : Colors.white,
    //         margin: settings.margin,
    //         avoidBottomPadding: settings.avoidBottomPadding,
    //         handleAndroidBackButtonPress: settings.handleAndroidBackButtonPress,
    //         resizeToAvoidBottomInset: settings.resizeToAvoidBottomInset,
    //         stateManagement: settings.stateManagement,
    //         hideNavigationBar: false,
    //         popAllScreensOnTapOfSelectedTab: true,
    //         onTabChanged: (index) {
    //           HapticFeedback.lightImpact();
    //           _selectedIndex = index;
    //           setState(() {
    //             _selectedIndex = index;
    //           });
    //         },
    //         navBarHeight: kBottomNavigationBarHeight,
    //       ),
    //       Positioned(
    //         bottom: kBottomNavBarHeight,
    //         child: Container(
    //           height: 2,
    //           width: MediaQuery.of(context).size.width,
    //           decoration: BoxDecoration(
    //             color: Colors.transparent,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.05),
    //                 blurRadius: 0.5,
    //                 offset: const Offset(0, -0.5),
    //                 // spreadRadius: 0,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         bottom: bottomSpace > 0 ? (kBottomNavBarHeight / 2) : kBottomNavBarHeight / 12,
    //         child: GestureDetector(
    //           onTap: () {
    //             onItemTapped(2);
    //             _controller.jumpToTab(2);
    //           },
    //           behavior: HitTestBehavior.opaque,
    //           child: Container(
    //             padding: EdgeInsets.only(top: 8.5, bottom: 5.86, left: 10, right: 12),
    //             width: 63,
    //             height: 65,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: settings.navBarColor,
    //               boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: Offset(0, -2))],
    //             ),
    //             child: Lottie.asset(repeat: false, 'assets/animations/skull_lottie_trimmed.json', fit: BoxFit.contain),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         bottom: kBottomNavBarHeight - 4,
    //         left:
    //             _selectedIndex == 0
    //                 ? width * 0.03
    //                 : _selectedIndex == 1
    //                 ? width * 0.23
    //                 : _selectedIndex == 3
    //                 ? width * 0.62
    //                 : _selectedIndex == 4
    //                 ? width * 0.815
    //                 : 0,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             color: _selectedIndex == 2 ? Colors.transparent : AppColor.kcPrimaryColor,
    //             borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
    //           ),
    //           height: 4,
    //           width: width * 0.15,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: "Top-Up"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
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
