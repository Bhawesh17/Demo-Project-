
import 'package:dio/dio.dart';
import 'endpoints.dart';
import 'interceptors/logger_interceptor.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);

  late final Dio _dio;



}


