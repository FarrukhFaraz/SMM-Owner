import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_owner/core/utils/navigation.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/auth/login/screens/login_screen.dart';

import 'core/storage/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    validateLogin();
  }

  validateLogin() async {
    String? token = await SecureStorageService.getString(CommonKeys.accessToken);
    if (kDebugMode) {
      print("Stored Token: $token");
    }
    if (token == null) {
      Timer(Duration(milliseconds: 2200), () {
        NavigationService.pushReplacement(LoginScreen());
      });
    } else {
      DioClient().setToken(token);
      Timer(Duration(milliseconds: 2200), () {
        // NavigationService.pushReplacement(HomePage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3C72), // Extracted Color 1
              Color(0xFF2A5298), // Extracted Color 2
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.ac_unit, // Replace with your logo
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text("SMM Owner", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 10),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
