import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/splash_screen.dart';

import 'config/theme/theme_cubit.dart';
import 'config/theme/theme_manager.dart';
import 'core/components/internet_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SMM Owner',
          theme: ThemeManager.lightTheme,
          darkTheme: ThemeManager.darkTheme,
          themeMode: themeMode,
          navigatorKey: NavigationService.navigatorKey,
          home: InternetStateWidget(child: SplashScreen()),
        );
      },
    );
  }
}
