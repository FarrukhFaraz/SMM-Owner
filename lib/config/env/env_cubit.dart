import 'package:flutter_bloc/flutter_bloc.dart';
import 'env_model.dart';
import 'env.dart';

class EnvCubit extends Cubit<ENVModel> {
  EnvCubit() : super(ENVModel.fromEnvironment(environment));

  /// Function to update environment dynamically (if needed in future)
  void updateEnv(Map<String, dynamic> newEnv) {
    emit(ENVModel.fromEnvironment(newEnv));
  }
}
