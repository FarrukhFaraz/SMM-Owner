import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiError implements Exception {
  final int? code;
  final String? message;

  ApiError({this.code, required this.message});

  factory ApiError.fromDioException(DioException dioException) {
    String defaultMessage = 'Something went wrong. Please try again.';
    if (dioException.response != null) {
      if (kDebugMode) {
        print('ApiError.fromDioException: ${dioException.response?.data}');
      }
      switch (dioException.response?.statusCode) {
        case 401:
          return ApiError(code: dioException.response?.statusCode, message: dioException.response?.data['message'] ?? defaultMessage);
        case 404:
          return ApiError(code: dioException.response?.statusCode, message: dioException.response?.data['message'] ?? defaultMessage);
        case 405:
          return ApiError(code: dioException.response?.statusCode, message: dioException.response?.data['message'] ?? defaultMessage);
        case 500:
          return ApiError(code: dioException.response?.statusCode, message: dioException.response?.data['message'] ?? defaultMessage);
        case 503:
          return ApiError(code: dioException.response?.statusCode, message: dioException.response?.data['message'] ?? defaultMessage);
        default:
          return ApiError(code: dioException.response?.statusCode ?? 0, message: dioException.response?.data['message'] ?? defaultMessage);
      }
    }
    /// Exception on socket/no internet
    else if (dioException.type == DioExceptionType.unknown) {
      return ApiError(code: 503, message: 'No internet');
    } else if (dioException.type == DioExceptionType.connectionError) {
      if (dioException.error.toString().contains("Failed host lookup")) {
        return ApiError(code: 503, message: 'No internet');
      } else {
        return ApiError(code: 500, message: 'Internal server error');
      }
    }
    /// Exceptions on timeout
    else if (dioException.type == DioExceptionType.connectionTimeout ||
        dioException.type == DioExceptionType.sendTimeout ||
        dioException.type == DioExceptionType.receiveTimeout) {
      return ApiError(code: 0, message: 'Time out, try again!');
    }

    return ApiError(code: dioException.response?.statusCode ?? 0, message: dioException.message ?? defaultMessage);
  }

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message)';
  }
}
