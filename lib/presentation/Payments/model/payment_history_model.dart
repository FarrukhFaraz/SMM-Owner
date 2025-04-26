class PaymentHistoryModel {
  int? id;
  int? userId;
  int? paymentMethodId;
  String? paymentMethod;
  String? amount;
  String? createdAt;
  String? updatedAt;

  PaymentHistoryModel({this.id, this.userId, this.paymentMethodId, this.paymentMethod, this.amount, this.createdAt, this.updatedAt});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentMethodId = json['payment_method_id'];
    paymentMethod = json['payment_method_name'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['payment_method_id'] = paymentMethodId;
    data['payment_method_name'] = paymentMethod;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
