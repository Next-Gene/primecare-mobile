import 'package:dio/dio.dart';
import '../constant/constant.dart';


abstract class DioHelper{
  static Dio? _dio;

  static Future<void> init()async{
    _dio = Dio(
        BaseOptions(
            baseUrl: BaseURL,
            receiveDataWhenStatusError: true,
            connectTimeout: const Duration(seconds: 20),
            validateStatus: (status){
              return (status! < 506);
            }
        )
    );
  }

  static Future<Response> getRequest({
    required String endPoint,
    required Map<String, dynamic>? queryParameters
  }) async {
    return await _dio!.get(
        endPoint,
        queryParameters: queryParameters
    );
  }

  static Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio!.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
    );
  }

}

