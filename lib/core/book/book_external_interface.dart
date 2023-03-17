import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/core/book/book_request.dart';
import 'package:clean_flutter/core/book/book_success_response.dart';
import 'package:dio/dio.dart';

class BookExternalInterface extends ExternalInterface<BookRequest, BookSuccessResponse> {
  BookExternalInterface({
    Dio? dio,
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://openlibrary.org/api/'));

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
