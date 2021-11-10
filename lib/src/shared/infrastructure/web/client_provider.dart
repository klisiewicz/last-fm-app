import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/config/provider/config_provider.dart';
import 'package:last_fm_app/src/shared/infrastructure/web/interceptors.dart';

final clientProvider = Provider<Dio>((Ref ref) {
  final apiKey = ref.watch(apiKeyProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://ws.audioscrobbler.com/2.0/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
  dio.interceptors.addAll([
    FormatRequestInterceptor(),
    ApiKeyInterceptor(apiKey),
  ]);
  return dio;
});
