class SignUpResponseModel {
  String? status;

  SignUpResponseModel({this.status});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(status: json['status']?.toString());
}
