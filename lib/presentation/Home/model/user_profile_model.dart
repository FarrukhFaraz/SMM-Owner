class UserProfileModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? number;
  int? balance;
  String? image;
  int? spend;
  String? status;
  String? lastAuth;
  int? discountPercentage;
  String? allowBelowSupplierPrice;
  String? ipAddress;
  String? country;
  String? skypeId;
  String? maritalStatus;
  String? addedById;
  String? role;
  String? createdAt;
  String? updatedAt;

  UserProfileModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.number,
    this.balance,
    this.spend,
    this.status,
    this.image,
    this.lastAuth,
    this.discountPercentage,
    this.allowBelowSupplierPrice,
    this.ipAddress,
    this.country,
    this.skypeId,
    this.maritalStatus,
    this.addedById,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    number = json['number'];
    balance = json['balance'];
    spend = json['spend'];
    status = json['status'];
    lastAuth = json['last_auth'];
    discountPercentage = json['discount_percentage'];
    allowBelowSupplierPrice = json['allow_below_supplier_price'];
    ipAddress = json['ip_address'];
    country = json['country'];
    skypeId = json['skype_id'];
    maritalStatus = json['marital_status'];
    addedById = json['added_by_id'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['number'] = number;
    data['balance'] = balance;
    data['spend'] = spend;
    data['status'] = status;
    data['last_auth'] = lastAuth;
    data['discount_percentage'] = discountPercentage;
    data['allow_below_supplier_price'] = allowBelowSupplierPrice;
    data['ip_address'] = ipAddress;
    data['country'] = country;
    data['skype_id'] = skypeId;
    data['marital_status'] = maritalStatus;
    data['added_by_id'] = addedById;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
