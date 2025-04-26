import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/env/env_cubit.dart';

class InternetStateWidget extends StatefulWidget {
  final Widget child;

  const InternetStateWidget({super.key, required this.child});

  @override
  State<InternetStateWidget> createState() => _InternetStateWidgetState();
}

class _InternetStateWidgetState extends State<InternetStateWidget> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isDialogVisible = false;

  @override
  void initState() {
    super.initState();
    EnvCubit cubit = context.read<EnvCubit>();
    cubit.updateEnv();
    _monitorInternet();
  }

  void _monitorInternet() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        _showNoInternetBottomSheet();
      } else {
        if (_isDialogVisible) {
          Navigator.pop(context); // Close sheet if internet is back
          _isDialogVisible = false;
        }
      }
    });
  }

  void _showNoInternetBottomSheet() {
    if (!_isDialogVisible) {
      _isDialogVisible = true;
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: Colors.white,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    const Text(
                      "No Internet Connection found.\nCheck your connection or try again.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    _buildOkButton(),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: Colors.red.shade600, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: const [
          Icon(Icons.signal_wifi_off, color: Colors.white, size: 40),
          SizedBox(height: 5),
          Text("Whoops!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildOkButton() {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child; // Wrap the entire app with this widget
  }
}
