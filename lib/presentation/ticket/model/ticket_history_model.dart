import 'package:sms_owner/presentation/order/model/order_model.dart';

class TicketHistoryModel {
  int? id;
  int? orderId;
  int? userId;
  int? domainId;
  String? subject;
  String? email;
  String? request;
  String? seen;
  String? category;
  String? subcategory;
  String? message;
  String? attachments;
  DateTime? createdAt;
  DateTime? updatedAt;
  OrderModel? order;
  Domain? domain;

  TicketHistoryModel({
    this.id,
    this.orderId,
    this.userId,
    this.domainId,
    this.subject,
    this.email,
    this.request,
    this.seen,
    this.category,
    this.subcategory,
    this.message,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.domain,
  });

  TicketHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    domainId = json['domain_id'];
    subject = json['subject'];
    email = json['email'];
    request = json['request'];
    seen = json['seen'];
    category = json['category'];
    subcategory = json['subcategory'];
    message = json['message'];
    attachments = json['attachments'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    order = json['order'] != null ? OrderModel.fromJson(json['order']) : null;
    domain = json['domain'] != null ? Domain.fromJson(json['domain']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['domain_id'] = domainId;
    data['subject'] = subject;
    data['email'] = email;
    data['request'] = request;
    data['seen'] = seen;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['message'] = message;
    data['attachments'] = attachments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (domain != null) {
      data['domain'] = domain!.toJson();
    }
    return data;
  }
}

class Domain {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Domain({this.id, this.name, this.createdAt, this.updatedAt});

  Domain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
