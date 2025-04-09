import 'package:sms_owner/core/network/api_error.dart';
import 'package:sms_owner/core/network/dio_client.dart';
import 'package:sms_owner/presentation/auth/sign_up/model/sign_up_response_model.dart';

class SignUpRepository {
  Future<SignUpResponseModel> signUp({
    required String name,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      Map<String, dynamic> body = {"name": name, "username": username, "email": email, "phone": phone, "password": password};
      final response = await DioClient().post('/register', data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        SignUpResponseModel responseModel = SignUpResponseModel.fromJson(response.data);
        return responseModel;
      }
      throw ApiError(message: response.data['message'] ?? 'Unexpected error occurred.', code: response.statusCode ?? 0);
    } catch (e) {
      throw ApiError(message: '$e', code: 0);
    }
  }
}
