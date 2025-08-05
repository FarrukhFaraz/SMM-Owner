import 'package:sms_owner/presentation/order/model/order_model.dart';

class CreateOrderModel {
  int? statusCode;
  String? message;
  Order? order;

  CreateOrderModel({this.message, this.order, this.statusCode});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}


class Order {
  int? serviceId;
  int? userId;
  int? domainId;
  String? type;
  String? status;
  String? link;
  String? quantity;
  String? total;
  String? currency;
  String? mode;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? externalStatus;
  String? systemMemo;
  String? comment;

  Order(
      {this.serviceId,
        this.userId,
        this.domainId,
        this.type,
        this.status,
        this.link,
        this.quantity,
        this.total,
        this.currency,
        this.mode,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.externalStatus,
        this.systemMemo,
        this.comment});

  Order.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    userId = json['user_id'];
    domainId = json['domain_id'];
    type = json['type'];
    status = json['status'];
    link = json['link'];
    quantity = json['quantity']?.toString();
    total = json['total']?.toString();
    currency = json['currency'];
    mode = json['mode'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    externalStatus = json['external_status'];
    systemMemo = json['system_memo'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['user_id'] = userId;
    data['domain_id'] = domainId;
    data['type'] = type;
    data['status'] = status;
    data['link'] = link;
    data['quantity'] = quantity;
    data['total'] = total;
    data['currency'] = currency;
    data['mode'] = mode;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['external_status'] = externalStatus;
    data['system_memo'] = systemMemo;
    data['comment'] = comment;
    return data;
  }
}
