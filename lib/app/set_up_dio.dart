import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:state_management_provider/app/configuration.dart';
import 'package:state_management_provider/core/network_executor/interceptors/core_interceptor.dart';

Dio getDioInstance() {
  BaseOptions dioOptions = BaseOptions(
    baseUrl: Configuration.baseUrl,
    connectTimeout: Configuration.connectionTimeOut,
    sendTimeout: Configuration.sendTimeOut,
    receiveTimeout: Configuration.receiveTimeOut,
    headers: {'content-type': 'application/json'},
  );

  final Dio dio = Dio(dioOptions);
  List<Interceptor> interceptors = [
    LogInterceptor(),
    CoreInterceptor(Configuration.baseUrl, basePath: Configuration.accessToken),
    RetryInterceptor(
      dio: dio,
      retries: 2,
      retryDelays: [Duration(seconds: 5), Duration(seconds: 10)],
    ),
  ];
  dio.interceptors.addAll(interceptors);
  return dio;
}
