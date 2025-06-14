import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/theme_cubit.dart';
import 'package:sms_owner/core/cubit/general_cubit/general_cubit.dart';
import 'package:sms_owner/core/storage/preferences.dart';
import 'package:sms_owner/presentation/Home/cubit/home_cubit.dart';
import 'package:sms_owner/presentation/Order/cubit/order_cubit.dart';
import 'package:sms_owner/presentation/Payments/cubit/add_fund/add_fund_cubit.dart';
import 'package:sms_owner/presentation/Payments/cubit/payment_history/payment_history_cubit.dart';
import 'package:sms_owner/presentation/Payments/cubit/payment_method/payment_method_cubit.dart';
import 'package:sms_owner/presentation/auth/login/cubit/login_cubit.dart';
import 'package:sms_owner/presentation/auth/sign_up/cubit/sign_up_cubit.dart';
import 'config/env/env_cubit.dart';
import 'my_app.dart';

void main() async {
  ///////////
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => EnvCubit()),
        BlocProvider(create: (_) => GeneralCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => AddFundCubit()),
        BlocProvider(create: (_) => PaymentHistoryCubit()),
        BlocProvider(create: (_) => PaymentMethodCubit()),
        BlocProvider(create: (_) => OrderCubit()),
      ],
      child: const MyApp(),
    ),
  );
}
