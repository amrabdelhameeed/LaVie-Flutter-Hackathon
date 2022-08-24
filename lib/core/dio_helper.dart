import 'package:dio/dio.dart';
import 'package:la_vie/core/widgets/api_strings.dart';
import 'app_strings.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: ApiStrings.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          "Access-Control_Allow_Origin": "*",
        }));
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'Authorization':
          AppStrings.token!.isNotEmpty ? 'Bearer ${AppStrings.token}' : '',
    };
    return dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      "Authorization": AppStrings.token,
    };
    return await dio!.put(url, queryParameters: query, data: data);
  }

  static Future<Response> patchData({
    String? token,
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer ${AppStrings.token}',
      'accept': 'application/json'
    };
    print(token);

    return await dio!.patch(url, data: data);
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    dio!.options.headers = {
      'Authorization': token != null ? 'Bearer  $token' : '',
    };
    return dio!.get(
      url,
      queryParameters: query,
    );
  }
}
