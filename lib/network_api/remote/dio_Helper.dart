import 'package:dio/dio.dart';
class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
       BaseOptions(
        baseUrl: 'https://primecareapi.runasp.net',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }



  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          // لو معاك توكن: 'Authorization': 'Bearer $token',
        },
      ),
    );
  }

}
