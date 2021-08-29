import 'package:dio/dio.dart';

Response<Map<String, dynamic>> okResponse(Map<String, dynamic> data) {
  return Response<Map<String, dynamic>>(
    requestOptions: RequestOptions(
      path: '',
    ),
    data: data,
    statusCode: 200,
    headers: Headers.fromMap({
      Headers.contentTypeHeader: [Headers.jsonContentType],
    }),
  );
}
