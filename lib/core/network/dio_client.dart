import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:sms_owner/core/utils/api_url.dart';

class DioClient extends DioForNative {
  String? _authToken;

  void setToken(String token) {
    _authToken = token;
  }

  DioClient() {
    options = BaseOptions(baseUrl: APIURL.baseUrl, responseType: ResponseType.json);
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_authToken != null) {
            options.headers.putIfAbsent('Authorization', () => 'Bearer $_authToken');
          }
          return handler.next(options);
        },
      ),
    );
    interceptors.add(LogInterceptor(request: false, requestHeader: false, requestBody: true, responseHeader: false, responseBody: true));
  }
}
