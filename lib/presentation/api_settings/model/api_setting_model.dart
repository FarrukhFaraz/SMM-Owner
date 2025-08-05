class ApiSettingModel {
  int? id;
  int? userId;
  int? domainId;
  String? httpMethod;
  String? apiUrl;
  String? apiKey;
  String? responseFormat;
  String? createdAt;
  String? updatedAt;

  ApiSettingModel({
    this.id,
    this.userId,
    this.domainId,
    this.httpMethod,
    this.apiUrl,
    this.apiKey,
    this.responseFormat,
    this.createdAt,
    this.updatedAt,
  });

  ApiSettingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    domainId = json['domain_id'];
    httpMethod = json['http_method'];
    apiUrl = json['api_url'];
    apiKey = json['api_key'];
    responseFormat = json['response_format'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['domain_id'] = domainId;
    data['http_method'] = httpMethod;
    data['api_url'] = apiUrl;
    data['api_key'] = apiKey;
    data['response_format'] = responseFormat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
