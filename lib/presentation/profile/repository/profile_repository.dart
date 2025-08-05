import 'package:dio/dio.dart';
import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/core/storage/secure_storage.dart';
import 'package:sms_owner/core/utils/common_keys.dart';
import 'package:sms_owner/presentation/profile/model/update_profile_model.dart';
import 'package:sms_owner/presentation/profile/model/user_model.dart';

class ProfileRepository {
  Future<UpdateProfileModel> fetchUpdateProfile() async {
    try {
      Map<String, dynamic> data ={
        'id':await SecureStorageService.getString(CommonKeys.userId),
      };
      final response = await DioClient().post('/user/get_update_profile' , data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        UpdateProfileModel responseList = UpdateProfileModel.fromJson(response.data['data']);
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

  Future<UserModel> fetchUserProfile() async {
    try {
      Map<String, dynamic> data ={
        'id':await SecureStorageService.getString(CommonKeys.userId),
      };
      final response = await DioClient().post('/user/profile' , data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel responseList = UserModel.fromJson(response.data['user']);
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

  Future<UserModel> updateUserProfile(Map<String, dynamic> data ) async {
    try {
      final response = await DioClient().post('/user/update-profile' , data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel responseList = UserModel.fromJson(response.data['user']);
        return responseList;
      }
      throw ApiError(code: 0, message: 'Something went wrong');
    } on DioException catch (e) {
      throw ApiError(code: 0, message: e.response?.data?['message']);
    } on TypeError catch (e) {
      throw ApiError(code: 0, message: e.toString());
    } catch (e) {
      throw ApiError(code: 0, message: e.toString());
    }
  }
}
