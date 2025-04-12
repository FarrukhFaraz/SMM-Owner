import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';

class ForgotPasswordRepository {
  Future<bool> sendOTP({required String email}) async {
    try {
      Map<String, dynamic> body = {"email": email};

      final response = await DioClient().post('/reset-password', data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      throw ApiError(message: response.data['message'] ?? 'Unexpected error occurred.', code: response.statusCode ?? 0);
    } on DioException catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      if (kDebugMode) {
        print(e.stackTrace);
      }
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<bool> verifyOTP({required String email, required String otp}) async {
    try {
      Map<String, dynamic> body = {"email": email, "code": otp};

      final response = await DioClient().post('/verify-otp', data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      throw ApiError(message: response.data['message'] ?? 'Unexpected error occurred.', code: response.statusCode ?? 0);
    } on DioException catch (e, stackTrace) {
      print(stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      print(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<bool> resendOTP({required String email}) async {
    try {
      Map<String, dynamic> body = {"email": email};

      final response = await DioClient().post('/reset-password', data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      throw ApiError(message: response.data['message'] ?? 'Unexpected error occurred.', code: response.statusCode ?? 0);
    } on DioException catch (e, stackTrace) {
      print(stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      print(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<bool> updatePassword({required String email, required String password}) async {
    try {
      Map<String, dynamic> body = {"email": email, "password": password};

      final response = await DioClient().post('/update-password', data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      throw ApiError(message: response.data['message'] ?? 'Unexpected error occurred.', code: response.statusCode ?? 0);
    } on DioException catch (e, stackTrace) {
      print(stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      print(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }
}
