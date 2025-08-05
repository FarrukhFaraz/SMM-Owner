import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/api_settings/model/api_setting_model.dart';

class ApiSettingRepository {
  Future<List<ApiSettingModel>> fetchAPISettings() async {
    try {
      Map<String, dynamic> data = {
        'user_id': await SecureStorageService.getString(CommonKeys.userId),
      };
      final response = await DioClient().post('/get-api-documentations', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ApiSettingModel> responseList = (response.data['data'] as List).map((data) => ApiSettingModel.fromJson(data)).toList();
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
