import 'package:flutter/material.dart';
import 'config_model/login_config.dart';
import 'env.dart';

class ENVModel {
  final LoginConfig loginConfig;

  ENVModel({required this.loginConfig});

  factory ENVModel.fromEnvironment(Map<String, dynamic> env) {
    return ENVModel(loginConfig: LoginConfig.fromMap(env["loginConfig"] ?? {}));
  }
}
