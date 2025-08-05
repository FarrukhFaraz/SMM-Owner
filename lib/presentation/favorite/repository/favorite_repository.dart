import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/favorite/model/favorite_model.dart';

class FavoriteRepository {
  Future<List<FavoriteModel>> fetchFavorites() async {
    try {
      Map<String, dynamic> data = {'user_id': await SecureStorageService.getString(CommonKeys.userId)};
      final response = await DioClient().post('/get-favorite-service', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<FavoriteModel> responseList =
        (response.data['data'] as List).map((data) {
          FavoriteModel model = FavoriteModel.fromJson(data);
          model.service?.isFavorite = true;
          return model;
        }).toList();
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

  Future<bool> removeFromFavorite(String serviceId) async {
    try {
      Map<String, dynamic> data = {
        'user_id': await SecureStorageService.getString(CommonKeys.userId),
        "service_id": serviceId,
      };
      final response = await DioClient().post('/delete-favorite-service', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      throw ApiError(code: 0, message: e.response?.data['message']);
    } on TypeError catch (e) {
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      throw ApiError(code: 0, message: e.toString());
    }
  }

  Future<bool> addToFavorite(String serviceId) async {
    try {
      Map<String, dynamic> data = {
        'user_id': await SecureStorageService.getString(CommonKeys.userId),
        'service_id': serviceId,
      };
      final response = await DioClient().post('/save-favorite-service', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      throw ApiError(code: 0, message: e.response?.data['message']);
    } on TypeError catch (e) {
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      throw ApiError(code: 0, message: e.toString());
    }
  }
}
