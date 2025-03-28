import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralState.initial());
  PackageInfo? packageInfo;

  Future<void> loadPackageInfoDetail() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
