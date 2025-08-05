class UserModel {
  int? id;
  int? domainId;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  int? emailVerified;
  String? number;
  int? numberVerified;
  double? balance;
  String? verifiedAt;
  double? spend;
  String? status;
  String? lastAuth;
  double? discountPercentage;
  String? allowBelowSupplierPrice;
  dynamic ipAddress;
  dynamic country;
  dynamic skypeId;
  String? role;
  dynamic telegram;
  dynamic website;
  dynamic whatsapp;
  String? registrationStatus;
  String? userStatus;
  String? twoFaStatus;
  String? apiRefill;
  dynamic authorizedWhatsapp;
  String? createdAt;
  String? updatedAt;
  dynamic addedById;
  String? maritalStatus;
  String? userType;
  dynamic otpCode;

  UserModel(
      {this.id,
        this.domainId,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.emailVerified,
        this.number,
        this.numberVerified,
        this.balance,
        this.verifiedAt,
        this.spend,
        this.status,
        this.lastAuth,
        this.discountPercentage,
        this.allowBelowSupplierPrice,
        this.ipAddress,
        this.country,
        this.skypeId,
        this.role,
        this.telegram,
        this.website,
        this.whatsapp,
        this.registrationStatus,
        this.userStatus,
        this.twoFaStatus,
        this.apiRefill,
        this.authorizedWhatsapp,
        this.createdAt,
        this.updatedAt,
        this.addedById,
        this.maritalStatus,
        this.userType,
        this.otpCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domainId = json['domain_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    emailVerified = json['email_verified'];
    number = json['number'];
    numberVerified = json['number_verified'];
    balance = double.tryParse('${json['balance']}');
    verifiedAt = json['verified_at'];
    spend = double.tryParse('${json['spend']}');
    status = json['status'];
    lastAuth = json['last_auth'];
    discountPercentage = double.tryParse('${json['discount_percentage']}');
    allowBelowSupplierPrice = json['allow_below_supplier_price'];
    ipAddress = json['ip_address'];
    country = json['country'];
    skypeId = json['skype_id'];
    role = json['role'];
    telegram = json['telegram'];
    website = json['website'];
    whatsapp = json['whatsapp'];
    registrationStatus = json['registration_status'];
    userStatus = json['user_status'];
    twoFaStatus = json['two_fa_status'];
    apiRefill = json['api_refill'];
    authorizedWhatsapp = json['authorized_whatsapp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addedById = json['added_by_id'];
    maritalStatus = json['marital_status'];
    userType = json['user_type'];
    otpCode = json['otp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['domain_id'] = domainId;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_verified'] = emailVerified;
    data['number'] = number;
    data['number_verified'] = numberVerified;
    data['balance'] = balance;
    data['verified_at'] = verifiedAt;
    data['spend'] = spend;
    data['status'] = status;
    data['last_auth'] = lastAuth;
    data['discount_percentage'] = discountPercentage;
    data['allow_below_supplier_price'] = allowBelowSupplierPrice;
    data['ip_address'] = ipAddress;
    data['country'] = country;
    data['skype_id'] = skypeId;
    data['role'] = role;
    data['telegram'] = telegram;
    data['website'] = website;
    data['whatsapp'] = whatsapp;
    data['registration_status'] = registrationStatus;
    data['user_status'] = userStatus;
    data['two_fa_status'] = twoFaStatus;
    data['api_refill'] = apiRefill;
    data['authorized_whatsapp'] = authorizedWhatsapp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['added_by_id'] = addedById;
    data['marital_status'] = maritalStatus;
    data['user_type'] = userType;
    data['otp_code'] = otpCode;
    return data;
  }
}