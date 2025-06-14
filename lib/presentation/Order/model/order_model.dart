class OrderModel {
  String? id;
  String? userId;
  String? orderId;
  String? serviceName;
  String? serviceDescription;
  String? serviceUrl;
  String? price;
  String? startCount;
  String? orderQuantity;
  String? totalQuantity;
  String? remainingQuantity;
  String? status;
  bool? refillAvailable;
  bool? canCancel;
  DateTime? orderedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderModel({
    this.id,
    this.orderId,
    this.userId,
    this.serviceName,
    this.serviceDescription,
    this.serviceUrl,
    this.price,
    this.status,
    this.refillAvailable,
    this.canCancel,
    this.startCount,
    this.orderQuantity,
    this.totalQuantity,
    this.remainingQuantity,
    this.orderedAt,
    this.createdAt,
    this.updatedAt,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    orderId = json['order_id']?.toString();
    userId = json['user_id']?.toString();
    serviceName = json['service_name']?.toString();
    serviceDescription = json['service_description']?.toString();
    serviceUrl = json['service_url']?.toString();
    price = json['price']?.toString();
    status = json['status']?.toString();
    refillAvailable =
        int.tryParse(json['refill_available']?.toString() ?? '0') == 0
            ? false
            : true;
    canCancel =
        int.tryParse(json['can_cancel']?.toString() ?? '0') == 0 ? false : true;
    startCount = json['start_count']?.toString();
    orderQuantity = json['order_quantity']?.toString();
    totalQuantity = json['total_quantity']?.toString();
    remainingQuantity = json['remains']?.toString();
    orderedAt = DateTime.tryParse(json['ordered_at']);
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['service_name'] = serviceName;
    data['service_description'] = serviceDescription;
    data['service_url'] = serviceUrl;
    data['price'] = price;
    data['status'] = status;
    data['refill_available'] = refillAvailable;
    data['can_cancel'] = canCancel;
    data['start_count'] = startCount;
    data['order_quantity'] = orderQuantity;
    data['total_quantity'] = totalQuantity;
    data['remains'] = remainingQuantity;
    data['ordered_at'] = orderedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
