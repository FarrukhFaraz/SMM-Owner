
class ServiceResponseModel {
  bool? success;
  int? currentPage;
  int? totalPages;
  List<ServiceModel>? service;

  ServiceResponseModel({this.success, this.currentPage, this.totalPages, this.service});

  ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      service = <ServiceModel>[];
      json['data'].forEach((v) {
        service!.add(ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    if (service != null) {
      data['data'] = service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ServiceModel {
  int? id;
  int? domainId;
  int? addedById;
  String? name;
  String? details;
  int? categoryId;
  String? mode;
  String? type;
  String? startCountType;
  bool? dripFeed;
  int? providerId;
  int? externalId;
  double? rate;
  double? providerRate;
  double? sellPercentage;
  String? priceMode;
  int? minOrder;
  int? maxOrder;
  int? minOrderProvider;
  int? maxOrderProvider;
  bool? minOrderSync;
  bool? maxOrderSync;
  bool? syncStatusProivder;
  double? overflow;
  double? downflow;
  String? priceVisibility;
  String? linkDuplicates;
  int? increments;
  bool? startCountParsing;
  String? providerStartCountFetching;
  dynamic count;
  bool? autoComplete;
  String? instantComplete;
  String? autoRemains;
  bool? refill;
  dynamic refillType;
  int? refillDays;
  dynamic refillTimes;
  dynamic refillBtnVisible;
  dynamic refillProvider;
  dynamic refillServiceId;
  dynamic refillProviderType;
  dynamic refillProviderMinQuant;
  dynamic refillProviderSendFullAmount;
  dynamic refillProviderAmountPercentage;
  dynamic refillProviderMaxAmountPercentage;
  String? enableCancelButton;
  String? status;
  dynamic adminSecretNote;
  dynamic disableBulkDiscounts;
  String? visibility;
  dynamic customVariables;
  dynamic linkVerification;
  dynamic stringToVerify;
  dynamic stringToBlock;
  double? position;
  dynamic createdAt;
  dynamic updatedAt;
  bool? isFavorite;
  ServiceCategoryModel? category;

  ServiceModel({
    this.id,
    this.domainId,
    this.addedById,
    this.name,
    this.details,
    this.categoryId,
    this.mode,
    this.type,
    this.startCountType,
    this.dripFeed,
    this.providerId,
    this.externalId,
    this.rate,
    this.providerRate,
    this.sellPercentage,
    this.priceMode,
    this.minOrder,
    this.maxOrder,
    this.minOrderProvider,
    this.maxOrderProvider,
    this.minOrderSync,
    this.maxOrderSync,
    this.syncStatusProivder,
    this.overflow,
    this.downflow,
    this.priceVisibility,
    this.linkDuplicates,
    this.increments,
    this.startCountParsing,
    this.providerStartCountFetching,
    this.count,
    this.autoComplete,
    this.instantComplete,
    this.autoRemains,
    this.refill,
    this.refillType,
    this.refillDays,
    this.refillTimes,
    this.refillBtnVisible,
    this.refillProvider,
    this.refillServiceId,
    this.refillProviderType,
    this.refillProviderMinQuant,
    this.refillProviderSendFullAmount,
    this.refillProviderAmountPercentage,
    this.refillProviderMaxAmountPercentage,
    this.enableCancelButton,
    this.status,
    this.adminSecretNote,
    this.disableBulkDiscounts,
    this.visibility,
    this.customVariables,
    this.linkVerification,
    this.stringToVerify,
    this.stringToBlock,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.isFavorite,
    this.category,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domainId = json['domain_id'];
    addedById = json['added_by_id'];
    name = json['name'];
    details = json['details'];
    categoryId = json['category_id'];
    mode = json['mode'];
    type = json['type'];
    startCountType = json['start_count_type'];
    dripFeed = json['drip_feed'];
    providerId = json['provider_id'];
    externalId = json['external_id'];
    rate = double.tryParse('${json['rate']}');
    providerRate = double.tryParse('${json['provider_rate']}');
    sellPercentage = double.tryParse('${json['sell_percentage']}');
    priceMode = json['price_mode'];
    minOrder = json['min_order'];
    maxOrder = json['max_order'];
    minOrderProvider = json['min_order_provider'];
    maxOrderProvider = json['max_order_provider'];
    minOrderSync = json['min_order_sync'];
    maxOrderSync = json['max_order_sync'];
    syncStatusProivder = json['sync_status_proivder'];
    overflow = double.tryParse('${json['overflow']}');
    downflow = double.tryParse('${json['downflow']}');
    priceVisibility = json['price_visibility'];
    linkDuplicates = json['link_duplicates'];
    increments = json['increments'];
    startCountParsing = json['start_count_parsing'];
    providerStartCountFetching = json['provider_start_count_fetching'];
    count = json['count'];
    autoComplete = json['auto_complete'];
    instantComplete = json['instant_complete'];
    autoRemains = json['auto_remains'];
    refill = json['refill'];
    refillType = json['refill_type'];
    refillDays = json['refill_days'];
    refillTimes = json['refill_times'];
    refillBtnVisible = json['refill_btn_visible'];
    refillProvider = json['refill_provider'];
    refillServiceId = json['refill_service_id'];
    refillProviderType = json['refill_provider_type'];
    refillProviderMinQuant = json['refill_provider_min_quant'];
    refillProviderSendFullAmount = json['refill_provider_send_full_amount'];
    refillProviderAmountPercentage = json['refill_provider_amount_percentage'];
    refillProviderMaxAmountPercentage = json['refill_provider_max_amount_percentage'];
    enableCancelButton = json['enable_cancel_button'];
    status = json['status'];
    adminSecretNote = json['admin_secret_note'];
    disableBulkDiscounts = json['disable_bulk_discounts'];
    visibility = json['visibility'];
    customVariables = json['custom_variables'];
    linkVerification = json['link_verification'];
    stringToVerify = json['string_to_verify'];
    stringToBlock = json['string_to_block'];
    position = double.tryParse('${json['position']}');
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFavorite = json['is_favorite'];
    category = json['category'] != null
        ? ServiceCategoryModel.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['domain_id'] = domainId;
    data['added_by_id'] = addedById;
    data['name'] = name;
    data['details'] = details;
    data['category_id'] = categoryId;
    data['mode'] = mode;
    data['type'] = type;
    data['start_count_type'] = startCountType;
    data['drip_feed'] = dripFeed;
    data['provider_id'] = providerId;
    data['external_id'] = externalId;
    data['rate'] = rate;
    data['provider_rate'] = providerRate;
    data['sell_percentage'] = sellPercentage;
    data['price_mode'] = priceMode;
    data['min_order'] = minOrder;
    data['max_order'] = maxOrder;
    data['min_order_provider'] = minOrderProvider;
    data['max_order_provider'] = maxOrderProvider;
    data['min_order_sync'] = minOrderSync;
    data['max_order_sync'] = maxOrderSync;
    data['sync_status_proivder'] = syncStatusProivder;
    data['overflow'] = overflow;
    data['downflow'] = downflow;
    data['price_visibility'] = priceVisibility;
    data['link_duplicates'] = linkDuplicates;
    data['increments'] = increments;
    data['start_count_parsing'] = startCountParsing;
    data['provider_start_count_fetching'] = providerStartCountFetching;
    data['count'] = count;
    data['auto_complete'] = autoComplete;
    data['instant_complete'] = instantComplete;
    data['auto_remains'] = autoRemains;
    data['refill'] = refill;
    data['refill_type'] = refillType;
    data['refill_days'] = refillDays;
    data['refill_times'] = refillTimes;
    data['refill_btn_visible'] = refillBtnVisible;
    data['refill_provider'] = refillProvider;
    data['refill_service_id'] = refillServiceId;
    data['refill_provider_type'] = refillProviderType;
    data['refill_provider_min_quant'] = refillProviderMinQuant;
    data['refill_provider_send_full_amount'] = refillProviderSendFullAmount;
    data['refill_provider_amount_percentage'] = refillProviderAmountPercentage;
    data['refill_provider_max_amount_percentage'] = refillProviderMaxAmountPercentage;
    data['enable_cancel_button'] = enableCancelButton;
    data['status'] = status;
    data['admin_secret_note'] = adminSecretNote;
    data['disable_bulk_discounts'] = disableBulkDiscounts;
    data['visibility'] = visibility;
    data['custom_variables'] = customVariables;
    data['link_verification'] = linkVerification;
    data['string_to_verify'] = stringToVerify;
    data['string_to_block'] = stringToBlock;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_favorite'] = isFavorite;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class ServiceCategoryModel {
  int? id;
  int? domainId;
  int? addedById;
  String? name;
  dynamic icon;
  dynamic image;
  String? status;
  String? comment;
  int? position;
  String? createdAt;
  String? updatedAt;

  ServiceCategoryModel(
      {this.id,
        this.domainId,
        this.addedById,
        this.name,
        this.icon,
        this.image,
        this.status,
        this.comment,
        this.position,
        this.createdAt,
        this.updatedAt});

  ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domainId = json['domain_id'];
    addedById = json['added_by_id'];
    name = json['name'];
    icon = json['icon'];
    image = json['image'];
    status = json['status'];
    comment = json['comment'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['domain_id'] = domainId;
    data['added_by_id'] = addedById;
    data['name'] = name;
    data['icon'] = icon;
    data['image'] = image;
    data['status'] = status;
    data['comment'] = comment;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}