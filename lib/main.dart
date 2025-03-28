import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/theme_cubit.dart';
import 'package:sms_owner/core/components/internet_state.dart';
import 'package:sms_owner/core/cubit/general_cubit.dart';
import 'package:sms_owner/core/storage/preferences.dart';

import 'config/env/env_cubit.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService.init();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit()), BlocProvider(create: (_) => EnvCubit()), BlocProvider(create: (_) => GeneralCubit())],
      child: InternetStateWidget(child: const MyApp()),
    ),
  );
}
