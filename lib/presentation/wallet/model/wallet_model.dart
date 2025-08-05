class WalletTransactionResponseModel {
  bool? success;
  List<WalletTransactionModel>? transactions;

  WalletTransactionResponseModel({this.success, this.transactions});

  WalletTransactionResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['transactions'] != null) {
      transactions = <WalletTransactionModel>[];
      json['transactions'].forEach((v) {
        transactions!.add(WalletTransactionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactionModel {
  int? id;
  int? domainId;
  int? userId;
  dynamic receiverId;
  dynamic paymentMethodId;
  dynamic transactionId;
  dynamic transactionReceipt;
  double? amount;
  int? bonusAmount;
  int? taxAmount;
  int? taxPercent;
  String? currency;
  String? exchangeRate;
  double? amountUsd;
  double? balanceBefore;
  double? balanceAfter;
  String? type;
  String? status;
  bool? permaReject;
  int? rejectCount;
  String? sourceType;
  int? sourceId;
  dynamic detail;
  String? memo;
  dynamic adminResponse;
  dynamic userComment;
  bool? isViewed;
  String? createdAt;
  String? updatedAt;

  WalletTransactionModel({
    this.id,
    this.domainId,
    this.userId,
    this.receiverId,
    this.paymentMethodId,
    this.transactionId,
    this.transactionReceipt,
    this.amount,
    this.bonusAmount,
    this.taxAmount,
    this.taxPercent,
    this.currency,
    this.exchangeRate,
    this.amountUsd,
    this.balanceBefore,
    this.balanceAfter,
    this.type,
    this.status,
    this.permaReject,
    this.rejectCount,
    this.sourceType,
    this.sourceId,
    this.detail,
    this.memo,
    this.adminResponse,
    this.userComment,
    this.isViewed,
    this.createdAt,
    this.updatedAt,
  });

  WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domainId = json['domain_id'];
    userId = json['user_id'];
    receiverId = json['receiver_id'];
    paymentMethodId = json['payment_method_id'];
    transactionId = json['transaction_id'];
    transactionReceipt = json['transaction_receipt'];
    amount = double.tryParse('${json['amount']}');
    bonusAmount = json['bonus_amount'];
    taxAmount = json['tax_amount'];
    taxPercent = json['tax_percent'];
    currency = json['currency'];
    exchangeRate = json['exchange_rate'];
    amountUsd = double.tryParse('${json['amount_usd']}');
    balanceBefore = double.tryParse('${json['balance_before']}');
    balanceAfter = double.tryParse('${json['balance_after']}');
    type = json['type'];
    status = json['status'];
    permaReject = json['perma_reject'];
    rejectCount = json['reject_count'];
    sourceType = json['source_type'];
    sourceId = json['source_id'];
    detail = json['detail'];
    memo = json['memo'];
    adminResponse = json['admin_response'];
    userComment = json['user_comment'];
    isViewed = json['is_viewed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['domain_id'] = domainId;
    data['user_id'] = userId;
    data['receiver_id'] = receiverId;
    data['payment_method_id'] = paymentMethodId;
    data['transaction_id'] = transactionId;
    data['transaction_receipt'] = transactionReceipt;
    data['amount'] = amount;
    data['bonus_amount'] = bonusAmount;
    data['tax_amount'] = taxAmount;
    data['tax_percent'] = taxPercent;
    data['currency'] = currency;
    data['exchange_rate'] = exchangeRate;
    data['amount_usd'] = amountUsd;
    data['balance_before'] = balanceBefore;
    data['balance_after'] = balanceAfter;
    data['type'] = type;
    data['status'] = status;
    data['perma_reject'] = permaReject;
    data['reject_count'] = rejectCount;
    data['source_type'] = sourceType;
    data['source_id'] = sourceId;
    data['detail'] = detail;
    data['memo'] = memo;
    data['admin_response'] = adminResponse;
    data['user_comment'] = userComment;
    data['is_viewed'] = isViewed;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
