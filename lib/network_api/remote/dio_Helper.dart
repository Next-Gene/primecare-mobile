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
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
