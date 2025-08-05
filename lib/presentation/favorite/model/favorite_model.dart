import 'package:sms_owner/presentation/service/model/service_model.dart';

class FavoriteModel {
  int? id;
  int? userId;
  int? serviceId;
  String? createdAt;
  String? updatedAt;
  ServiceModel? service;

  FavoriteModel({this.id, this.userId, this.serviceId, this.createdAt, this.updatedAt, this.service});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service = json['service'] != null ? ServiceModel.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}
