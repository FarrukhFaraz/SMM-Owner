import 'package:sms_owner/presentation/profile/model/user_model.dart';

class TicketMessageModel {
  int? id;
  int? ticketId;
  int? userId;
  String? message;
  String? attachments;
  bool? isMe;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;

  TicketMessageModel({
    this.id,
    this.ticketId,
    this.userId,
    this.message,
    this.attachments,
    this.isMe,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  TicketMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    userId = json['user_id'];
    message = json['message'];
    attachments = json['attachments'];
    isMe = json['is_me'];
    isRead = json['is_read'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ticket_id'] = ticketId;
    data['user_id'] = userId;
    data['message'] = message;
    data['attachments'] = attachments;
    data['is_me'] = isMe;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
