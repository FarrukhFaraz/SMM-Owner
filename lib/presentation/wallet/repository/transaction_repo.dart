import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';

import '../model/wallet_model.dart';

class TransactionRepository {
  Future<List<WalletTransactionModel>> getUserTransactions() async {
    try {
      Map<String,dynamic> data = {
        "user_id": await SecureStorageService.getString(CommonKeys.userId),
      };
      final response = await DioClient().post('/user-transactions' , data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseModel = WalletTransactionResponseModel.fromJson(response.data);

        if (responseModel.success == true) {
          return responseModel.transactions ?? [];
        } else {
          throw ApiError(message: 'Failed to fetch transactions', code: response.statusCode);
        }
      } else {
        throw ApiError(message: 'HTTP Error: ${response.statusCode}', code: response.statusCode);
      }
    } on DioException catch (dioError) {
      throw _handleDioException(dioError);
    } catch (e) {
      throw ApiError(message: 'Unexpected error: ${e.toString()}', code: 500);
    }
  }

  ApiError _handleDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Connection timeout. Please check your internet connection.', code: 408);

      case DioExceptionType.connectionError:
        return ApiError(message: 'No internet connection available.', code: 0);

      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode ?? 500;
        final message = dioError.response?.data?['message'] ?? 'Server error occurred';

        return ApiError(message: message, code: statusCode);

      default:
        return ApiError(message: 'Network error: ${dioError.message}', code: dioError.response?.statusCode ?? 500);
    }
  }
}
