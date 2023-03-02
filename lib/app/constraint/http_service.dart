import 'package:dio/dio.dart';
import 'package:techies_battle/app/constraint/app_url.dart';

class HttpServices {
  // private named constructor
  HttpServices._internal();

  static final HttpServices _instance = HttpServices._internal();

  factory HttpServices() => _instance;

  static Dio? _dio; // for network call ko lagi

  Dio getDioInstance() {
    if (_dio == null) {
      // naya dio/ i mean network call garne yuta object banau dio ko
      _dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: 5000));

      // adding interceptor for developer
      // _dio?.interceptors
      //     .add(DioLoggingInterceptor(level: Level.body, compact: false));

      return _dio!;
    } else {
      return _dio!;
    }
  }
}
