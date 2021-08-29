import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

@immutable
class FormatRequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['format'] = 'json';
    return super.onRequest(options, handler);
  }
}

@immutable
class ApiKeyInterceptor extends Interceptor {
  final String _apiKey;

  ApiKeyInterceptor(String apiKey) : _apiKey = apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['api_key'] = _apiKey;
    return super.onRequest(options, handler);
  }
}
