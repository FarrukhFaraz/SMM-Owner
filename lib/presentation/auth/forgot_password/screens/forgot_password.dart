import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 80, color: Colors.teal).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5, end: 0),
                SizedBox(height: 20),
                Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ).animate().fadeIn(duration: 800.ms),
                SizedBox(height: 8),
                Text(
                  'No worries, we’ll send you reset instructions',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 1000.ms),
                SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.teal)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.teal, width: 2)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ).animate().fadeIn(duration: 1200.ms),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {},
                  child: Text('Send Code on Email', style: TextStyle(fontSize: 16)),
                ).animate().fadeIn(duration: 1400.ms).slideY(begin: 0.3, end: 0),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.teal),
                      SizedBox(width: 5),
                      Text('Back to Login', style: TextStyle(fontSize: 16, color: Colors.teal)),
                    ],
                  ),
                ).animate().fadeIn(duration: 1600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
