import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/presentation/auth/login/model/login_model.dart';

class LoginRepository {
  Future<LoginResponseModel> login({required String username, required String password}) async {
    try {
      Map<String, dynamic> body = {"login": username, "password": password};

      final response = await DioClient().post('/login', data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoginResponseModel responseModel = LoginResponseModel.fromJson(response.data);
        return responseModel;
      }
      throw ApiError(message: response.data['message'] ?? 'Unexpected error occurred.', code: response.statusCode ?? 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }
}
