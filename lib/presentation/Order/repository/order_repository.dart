import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/presentation/Order/model/order_model.dart';

class OrderRepository {
  Future<List<OrderModel>> fetchOrders(Map<String, dynamic> data) async {
    try {
      final response = await DioClient().post('/orders', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<OrderModel> responseList =
            (response.data['orders'] as List)
                .map((data) => OrderModel.fromJson(data))
                .toList();
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
}
