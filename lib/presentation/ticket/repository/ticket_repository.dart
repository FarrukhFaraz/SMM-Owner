import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/ticket/model/ticket_history_model.dart';

import '../model/ticket_message_model.dart';

class TicketRepository {
  Future<List<TicketHistoryModel>> getTickets() async {
    try {
      final response = await DioClient().post('/get-tickets', data: {"user_id": await SecureStorageService.getString(CommonKeys.userId)});

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<TicketHistoryModel> responseList = (response.data['data'] as List).map((data) => TicketHistoryModel.fromJson(data)).toList();
        return responseList;
      }
      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      throw ApiError(code: 0, message: e.message);
    } on TypeError catch (e) {
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      throw ApiError(code: 0, message: e.toString());
    }
  }

  Future<bool> saveTickets({required Map<String, dynamic> body}) async {
    try {
      final response = await DioClient().post('/save-tickets', data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      print('TicketRepository.DioException::::: ${e.response?.data['errors']}');
      throw ApiError(code: 0, message: e.response?.data['errors']);
    } on TypeError catch (e) {
      print('TicketRepository.TypeError');
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      print('TicketRepository.catch');
      throw ApiError(code: 0, message: e.toString());
    }
  }

  Future<List<TicketMessageModel>> getTicketMessages({required String ticketId}) async {
    try {
      final response = await DioClient().post('/ticket/get-messages', data: {"ticket_id": ticketId});

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<TicketMessageModel> responseList = (response.data['data'] as List).map((data) => TicketMessageModel.fromJson(data)).toList();
        return responseList;
      }
      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      throw ApiError(code: 0, message: e.message);
    } on TypeError catch (e) {
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      throw ApiError(code: 0, message: e.toString());
    }
  }

  Future<TicketMessageModel> saveTicketMessage({required Map<String, dynamic> body}) async {
    try {
      final response = await DioClient().post('/ticket/save-message', data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        TicketMessageModel message = TicketMessageModel.fromJson(response.data['data']);

        return message;
      }
      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      throw ApiError(code: 0, message: e.message);
    } on TypeError catch (e) {
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      throw ApiError(code: 0, message: e.toString());
    }
  }
}
