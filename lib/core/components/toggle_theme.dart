import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/theme_cubit.dart';

class ToggleThemeWidget extends StatelessWidget {
  const ToggleThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Toggle Theme", style: TextStyle(fontSize: 18)),
        Spacer(),
        Switch(
          value: context.read<ThemeCubit>().state == ThemeMode.dark,
          onChanged: (value) {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ],
    );
  }
}
