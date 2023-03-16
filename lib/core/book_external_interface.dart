import 'package:clean_flutter/core/book_request.dart';
import 'package:clean_flutter/core/book_success_response.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:dio/dio.dart';

class BookExternalInterface extends ExternalInterface<GetBookRequest, BookSuccessResponse> {
  BookExternalInterface({
    Dio? dio,
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://openlibrary.org/'));

  final Dio _dio;

  @override
  void handleRequest() {
    on<GetBookRequest>(
      (request, send) async {
        final response = await _dio.get<Map<String, dynamic>>(
          request.resource,
          queryParameters: request.queryParams,
        );

        final data = response.data!;

        send(BookSuccessResponse(data: data));
      },
    );
  }

  @override
  FailureResponse onError(Object error) {
    return UnknownFailureResponse(error);
  }
}
