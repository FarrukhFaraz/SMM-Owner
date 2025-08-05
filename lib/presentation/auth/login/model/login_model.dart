
import 'package:sms_owner/presentation/profile/model/user_model.dart';

class LoginResponseModel {
  int? statusCode;
  String? message;
  UserModel? user;
  String? token;

  LoginResponseModel({this.statusCode, this.message, this.user, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statuscode'];
    message = json['message'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statuscode'] = statusCode;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
