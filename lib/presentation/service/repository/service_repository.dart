import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/service/model/service_model.dart';

class ServiceRepository {
  Future<ServiceResponseModel> fetchAllService(Map<String,  dynamic> queryParam) async {
    try {
      Map<String, dynamic> data = {'user_id': await SecureStorageService.getString(CommonKeys.userId)};
      final response = await DioClient().post('/service/all', data: data, queryParameters: queryParam);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ServiceResponseModel serviceResponseModel = ServiceResponseModel.fromJson(response.data);
        return serviceResponseModel;
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

  Future<ServiceResponseModel> fetchServicesByCategory(String categoryId) async {
    try {
      Map<String, dynamic> data = {'category_id': categoryId};
      final response = await DioClient().post('/service-by-category', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ServiceResponseModel serviceResponseModel = ServiceResponseModel.fromJson(response.data);
        return serviceResponseModel;
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

  Future<List<ServiceCategoryModel>> fetchCategory() async {
    try {
      final response = await DioClient().post('/service-category');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ServiceCategoryModel> responseList = (response.data['data'] as List).map((data) => ServiceCategoryModel.fromJson(data)).toList();
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
