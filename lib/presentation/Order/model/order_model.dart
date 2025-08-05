import 'package:sms_owner/presentation/service/model/service_model.dart';

class OrderModel {
  int? id;
  int? domainId;
  int? userId;
  int? serviceId;
  dynamic externalId;
  String? type;
  String? status;
  String? externalStatus;
  String? mode;
  String? link;
  int? quantity;
  int? startCount;
  dynamic currentCount;
  dynamic remains;
  String? charge;
  String? total;
  String? refundedAmount;
  String? currency;
  dynamic staffMemo;
  String? systemMemo;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  ServiceModel? service;

  OrderModel({
    this.id,
    this.domainId,
    this.userId,
    this.serviceId,
    this.externalId,
    this.type,
    this.status,
    this.externalStatus,
    this.mode,
    this.link,
    this.quantity,
    this.startCount,
    this.currentCount,
    this.remains,
    this.charge,
    this.total,
    this.refundedAmount,
    this.currency,
    this.staffMemo,
    this.systemMemo,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domainId = json['domain_id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    externalId = json['external_id'];
    type = json['type'];
    status = json['status'];
    externalStatus = json['external_status'];
    mode = json['mode'];
    link = json['link'];
    quantity = json['quantity'];
    startCount = json['start_count'];
    currentCount = json['current_count'];
    remains = json['remains'];
    charge = json['charge'];
    total = json['total'];
    refundedAmount = json['refunded_amount'];
    currency = json['currency'];
    staffMemo = json['staff_memo'];
    systemMemo = json['system_memo'];
    comment = json['comment'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    service = json['service'] != null ? ServiceModel.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['domain_id'] = domainId;
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['external_id'] = externalId;
    data['type'] = type;
    data['status'] = status;
    data['external_status'] = externalStatus;
    data['mode'] = mode;
    data['link'] = link;
    data['quantity'] = quantity;
    data['start_count'] = startCount;
    data['current_count'] = currentCount;
    data['remains'] = remains;
    data['charge'] = charge;
    data['total'] = total;
    data['refunded_amount'] = refundedAmount;
    data['currency'] = currency;
    data['staff_memo'] = staffMemo;
    data['system_memo'] = systemMemo;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}