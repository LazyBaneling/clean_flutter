import 'package:flutter_test/flutter_test.dart';
import 'package:clean_flutter/core/book/hardcoded_isbns.dart';
import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/core/book/book_success_response.dart';
import 'package:clean_flutter/features/index/external_interface/book_collection_gateway.dart';

void main() {
  group('BookCollectionGateway tests |', () {
    test('verify request', () async {
      final gateway = BookCollectionGateway();
      final gatewayOutput = BookCollectionGatewayOutput();

      final request = gateway.buildRequest(gatewayOutput);

      expect(request.resource, equals('books'));
      expect(
        request.queryParams,
        equals({
          'bibkeys': hardCodedIsbns.map((isbn) => 'ISBN:$isbn').join(','),
          'jscmd': 'data',
          'format': 'json',
        }),
      );

      expect(gatewayOutput, BookCollectionGatewayOutput());
    });

    test('success', () async {
      final gateway = BookCollectionGateway()
        ..feedResponse(
          (request) async => const Either.right(
            BookSuccessResponse(
              data: {
                'ISBN:123': {
                  'title': 'Book Title 1',
                  'authors': [
                    {'name': 'Author 1'},
                  ],
                  'cover': {'medium': 'https://example.com/cover1.jpg'},
                  'publish_date': '2023-01-01',
                  'number_of_pages': 100,
                },
                'ISBN:456': {
                  'title': 'Book Title 2',
                  'authors': [
                    {'name': 'Author 2'},
                  ],
                  'cover': {'medium': 'https://example.com/cover2.jpg'},
                  'publish_date': '2022-12-31',
                  'number_of_pages': 200,
                },
              },
            ),
          ),
        );

      final input = await gateway.buildInput(BookCollectionGatewayOutput());

      expect(input.isRight, isTrue);

      final identities = input.right.bookIdentities;

      expect(identities.first.title, equals('Book Title 1'));
      expect(identities.first.isbn, equals('123'));
      expect(identities.first.numberOfPages, equals(100));

      expect(identities.last.title, equals('Book Title 2'));
      expect(identities.last.isbn, equals('456'));
      expect(identities.last.numberOfPages, equals(200));
    });

    test('failure', () async {
      final gateway = BookCollectionGateway()
        ..feedResponse(
          (request) async => Either.left(
            UnknownFailureResponse('No Internet'),
          ),
        );

      final input = await gateway.buildInput(BookCollectionGatewayOutput());

      expect(input.isLeft, isTrue);

      expect(input.left.message, equals('No Internet'));
    });
  });
}
