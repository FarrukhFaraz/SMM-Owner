import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/presentation/Home/model/user_profile_model.dart';

class HomeRepository {
  Future<UserProfileModel> getProfile({required String id}) async {
    try {
      Map<String, dynamic> body = {"id": id};
      print('HomeRepository.getProfile:::: $body');
      final response = await DioClient().post('/user/profile', data: body);
      print('HomeRepository.getProfile::::: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserProfileModel responseModel = UserProfileModel.fromJson(response.data['data']);
        return responseModel;
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
