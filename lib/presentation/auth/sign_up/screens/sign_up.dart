import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's\nCreate Your\nAccount",
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ).animate().fade(duration: 800.ms).slideY(begin: -0.5, end: 0),
              SizedBox(height: 20),
              _buildTextField(Icons.person, "Full Name"),
              _buildTextField(Icons.account_circle, "Username"),
              _buildTextField(Icons.email, "Email Address"),
              _buildTextField(Icons.phone, "WhatsApp"),
              _buildTextField(Icons.lock, "Password", obscureText: true),
              _buildTextField(Icons.lock, "Retype Password", obscureText: true),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  Text("I agree to the "),
                  Text("Terms & Privacy", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
              ).animate().fade(duration: 500.ms).slideY(begin: 0.5, end: 0),
              SizedBox(height: 15),
              Center(child: Text("or")),
              SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/google_logo.png', height: 20),
                label: Text("Login with Google"),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text("Have an account? Sign In", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.teal),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
        ),
      ).animate().fade(duration: 600.ms).slideY(begin: 0.5, end: 0),
    );
  }
}
