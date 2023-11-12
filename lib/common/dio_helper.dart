import 'package:dio/dio.dart';
import 'package:zetaton_flutter_task/common/constants.dart';

class DioHelper {
  /// helper class for http requests using Dio package
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
