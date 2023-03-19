import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/core/book/book_success_response.dart';
import 'package:clean_flutter/features/details/external_interface/book_details_gateway.dart';

void main() {
  group('BookDetailsGateway tests |', () {
    test('verify request', () async {
      final gateway = BookDetailsGateway();
      const gatewayOutput = BookDetailsGatewayOutput(isbn: '1234567890');

      final request = gateway.buildRequest(gatewayOutput);

      expect(request.resource, equals('books'));
      expect(
        request.queryParams,
        equals({
          'bibkeys': 'ISBN:1234567890',
          'jscmd': 'data',
          'format': 'json',
        }),
      );

      expect(gatewayOutput, const BookDetailsGatewayOutput(isbn: '1234567890'));
    });

    test('success', () async {
      final gateway = BookDetailsGateway()
        ..feedResponse(
          (request) async => const Either.right(
            BookSuccessResponse(
              data: {
                'ISBN:1234567890': {
                  'title': 'example book',
                  'authors': [
                    {'name': 'Author 1'},
                    {'name': 'Author 2'}
                  ],
                  'number_of_pages': 100,
                  'publish_date': '2022-01-01',
                  'cover': {'medium': 'http://example.com/cover.jpg'},
                },
              },
            ),
          ),
        );

      final input = await gateway.buildInput(const BookDetailsGatewayOutput(isbn: 'ISBN:1234567890'));

      expect(input.isRight, isTrue);

      final bookDetails = input.right.bookDetails;

      expect(bookDetails.title, equals('example book'));
      expect(bookDetails.authors, equals(['Author 1', 'Author 2']));
      expect(bookDetails.numberOfPages, equals(100));
      expect(bookDetails.publishDate, equals('2022-01-01'));
      expect(bookDetails.cover, equals('http://example.com/cover.jpg'));
    });

    test('failure', () async {
      final gateway = BookDetailsGateway()
        ..feedResponse(
          (request) async => Either.left(
            UnknownFailureResponse('No Internet'),
          ),
        );

      final input = await gateway.buildInput(const BookDetailsGatewayOutput(isbn: '1234567890'));

      expect(input.isLeft, isTrue);

      expect(input.left.message, equals('No Internet'));
    });
  });
}
