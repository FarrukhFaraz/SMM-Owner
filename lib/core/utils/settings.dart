import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

typedef NavBarBuilder = Widget Function(NavBarConfig, NavBarDecoration, ItemAnimation, NeumorphicProperties);

class Settings {
  bool hideNavBar = false;
  bool resizeToAvoidBottomInset = true;
  bool stateManagement = true;
  bool handleAndroidBackButtonPress = true;
  bool popAllScreensOnTapOfSelectedTab = true;
  bool avoidBottomPadding = true;
  Color navBarColor = Colors.white;
  NavBarBuilder get navBarBuilder => navBarStyles[navBarStyle]!;
  String navBarStyle = "Style 1";
  EdgeInsets margin = EdgeInsets.zero;

  Map<String, NavBarBuilder> navBarStyles = {
    "Neumorphic": (p0, p1, p2, p3) => NeumorphicBottomNavBar(navBarConfig: p0, navBarDecoration: p1, neumorphicProperties: p3),
    "Style 1": (p0, p1, p2, p3) => Style1BottomNavBar(navBarConfig: p0, navBarDecoration: p1),
    "Style 2": (p0, p1, p2, p3) => Style2BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 3": (p0, p1, p2, p3) => Style3BottomNavBar(navBarConfig: p0, navBarDecoration: p1),
    "Style 4": (p0, p1, p2, p3) => Style4BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 5": (p0, p1, p2, p3) => Style5BottomNavBar(navBarConfig: p0, navBarDecoration: p1),
    "Style 6": (p0, p1, p2, p3) => Style6BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 7": (p0, p1, p2, p3) => Style7BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 8": (p0, p1, p2, p3) => Style8BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 9": (p0, p1, p2, p3) => Style9BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 10": (p0, p1, p2, p3) => Style10BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 11": (p0, p1, p2, p3) => Style11BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 12": (p0, p1, p2, p3) => Style12BottomNavBar(navBarConfig: p0, navBarDecoration: p1, itemAnimationProperties: p2),
    "Style 13": (p0, p1, p2, p3) => Style13BottomNavBar(navBarConfig: p0, navBarDecoration: p1),
    "Style 14": (p0, p1, p2, p3) => Style14BottomNavBar(navBarConfig: p0, navBarDecoration: p1),
    "Style 15": (p0, p1, p2, p3) => Style15BottomNavBar(navBarConfig: p0, navBarDecoration: p1),
    "Style 16": (p0, p1, p2, p3) => Style16BottomNavBar(navBarConfig: p0, navBarDecoration: p1),
  };
}
