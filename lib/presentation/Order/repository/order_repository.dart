import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/presentation/order/model/order_model.dart';
import 'package:sms_owner/presentation/order/model/create_order_model.dart';

import '../../../core/storage/secure_storage.dart';
import '../../../core/utils/common_keys.dart';

class OrderRepository {
  Future<List<OrderModel>> fetchUsersOrders() async {
    try {
      var data = {
        "user_id" : await SecureStorageService.getString(CommonKeys.userId),
      };
      final response = await DioClient().post('/getUsersOrders',data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<OrderModel> responseList = (response.data['orders'] as List).map((data) => OrderModel.fromJson(data)).toList();
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

  Future<List<OrderModel>> fetchOrders() async {
    try {
      var data = {
        "user_id" : await SecureStorageService.getString(CommonKeys.userId),
      };
      final response = await DioClient().post('/orders', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<OrderModel> responseList = (response.data['orders'] as List).map((data) => OrderModel.fromJson(data)).toList();
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

  Future<CreateOrderModel?> createOrders(Map<String, dynamic> data) async {
    try {

      final response = await DioClient().post('/order/create', data: data );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CreateOrderModel createOrderModel= CreateOrderModel.fromJson(response.data);
        createOrderModel.statusCode = 200;
        return createOrderModel;
      }
      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      throw ApiError(code: 0, message: jsonEncode(e.response?.data));
    } on TypeError catch (e) {
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      throw ApiError(code: 0, message: e.toString());
    }
  }
}
