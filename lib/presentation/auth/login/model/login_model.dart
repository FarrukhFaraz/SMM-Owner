class LoginResponseModel {
  String? status;

  LoginResponseModel({this.status});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(status: json['status']?.toString());
}
