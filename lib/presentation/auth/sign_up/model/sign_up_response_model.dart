
import 'package:sms_owner/presentation/profile/model/user_model.dart';

class SignUpResponseModel {
  int? statuscode;
  String? message;
  UserModel? user;

  SignUpResponseModel({this.statuscode, this.message, this.user});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statuscode'] = statuscode;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
