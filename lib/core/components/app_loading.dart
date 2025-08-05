import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black38, alignment: Alignment.center, child: Center(child: CircularProgressIndicator()));
  }
}
