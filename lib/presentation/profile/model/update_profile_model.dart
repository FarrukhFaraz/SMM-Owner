import 'package:sms_owner/presentation/order/model/order_model.dart';
import 'package:sms_owner/presentation/profile/model/user_model.dart';
import 'package:sms_owner/presentation/ticket/model/ticket_history_model.dart';

class UpdateProfileModel {
  UserModel? user;
  OrderModel? latestOrder;
  TicketHistoryModel? latestTicket;

  UpdateProfileModel({this.user, this.latestOrder, this.latestTicket});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    latestOrder = json['latest_order'] != null ? OrderModel.fromJson(json['latest_order']) : null;
    latestTicket = json['latest_ticket'] != null ? TicketHistoryModel.fromJson(json['latest_ticket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (latestOrder != null) {
      data['latest_order'] = latestOrder!.toJson();
    }
    if (latestTicket != null) {
      data['latest_ticket'] = latestTicket!.toJson();
    }
    return data;
  }
}
