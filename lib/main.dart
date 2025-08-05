import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/config/theme/theme_cubit.dart';
import 'package:sms_owner/core/cubit/general_cubit/general_cubit.dart';
import 'package:sms_owner/core/storage/preferences.dart';
import 'package:sms_owner/presentation/order/cubit/order_cubit.dart';
import 'package:sms_owner/presentation/payments/cubit/add_fund/add_fund_cubit.dart';
import 'package:sms_owner/presentation/payments/cubit/payment_history/payment_history_cubit.dart';
import 'package:sms_owner/presentation/payments/cubit/payment_method/payment_method_cubit.dart';
import 'package:sms_owner/presentation/api_settings/cubit/api_settings_cubit.dart';
import 'package:sms_owner/presentation/auth/login/cubit/login_cubit.dart';
import 'package:sms_owner/presentation/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:sms_owner/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:sms_owner/presentation/home/cubit/home_cubit.dart';
import 'package:sms_owner/presentation/profile/cubit/profile_cubit.dart';
import 'package:sms_owner/presentation/service/cubit/service_cubit/service_cubit.dart';
import 'package:sms_owner/presentation/ticket/cubit/create_ticket/create_ticket_cubit.dart';
import 'package:sms_owner/presentation/ticket/cubit/ticket_history/ticket_history_cubit.dart';
import 'package:sms_owner/presentation/ticket/cubit/ticket_message/ticket_message_cubit.dart';
import 'package:sms_owner/presentation/wallet/cubit/wallet_cubit.dart';

import 'config/env/env_cubit.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
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
        BlocProvider(create: (_) => CreateTicketCubit()),
        BlocProvider(create: (_) => TicketHistoryCubit()),
        BlocProvider(create: (_) => TicketMessageCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => ApiSettingsCubit()),
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => ServiceCubit()),
        BlocProvider(create: (_) => WalletCubit()),
      ],
      child: const MyApp(),
    ),
  );
}
