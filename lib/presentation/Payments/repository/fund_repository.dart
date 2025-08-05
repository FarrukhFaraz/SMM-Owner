import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/payments/model/payment_model.dart';
import 'package:sms_owner/presentation/payments/model/payment_history_model.dart';

class FundsRepository {
  Future<List<PaymentModel>> loadPaymentMethods() async {
    try {
      final response = await DioClient().get('/meta-payment');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<PaymentModel> responseList =
            (response.data as List)
                .map((data) => PaymentModel.fromJson(data))
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

  Future<bool> addFunds({
    required int paymentId,
    required double amount,
    String? detail
  }) async {
    try {
      Map<String, dynamic> body = {
        "user_id": await SecureStorageService.getString(CommonKeys.userId),
        "payment_meta_id": paymentId,
        "amount": amount,
        "detail": detail,
      };

      final response = await DioClient().post('/save-payment', data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
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

  Future<List<PaymentHistoryModel>> loadPaymentHistory() async {
    Map<String, dynamic> body = {
      "user_id": await SecureStorageService.getString(CommonKeys.userId),
    };

    try {
      final response = await DioClient().post('/get-payment', data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<PaymentHistoryModel> responseList =
            (response.data as List)
                .map((data) => PaymentHistoryModel.fromJson(data))
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
