import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';

import 'package:clean_flutter/features/details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/details/domain/book_details_use_case.dart';
import 'package:clean_flutter/features/details/external_interface/book_details_gateway.dart';
import 'package:clean_flutter/providers.dart';

import '../../../test_data.dart';

void main() {
  group('BookDetailsUseCase tests |', () {
    useCaseTest<BookDetailsUseCase, BookDetailsEntity, BookDetailsUIOutput>(
      'fetches book details',
      provider: bookDetailsUseCaseProvider,
      execute: (useCase) {
        useCase.subscribe<BookDetailsGatewayOutput, BookDetailsSuccessInput>(
          (output) {
            return Either.right(
              BookDetailsSuccessInput(
                bookDetails: bookDetailsModel,
              ),
            );
          },
        );

        useCase.fetchBookDetails('978-3-16-148410-0');
      },
      expect: () => [
        BookDetailsUIOutput(
          title: bookDetailsModel.title,
          authors: bookDetailsModel.authors,
          isbn: bookDetailsModel.isbn,
          cover: bookDetailsModel.cover,
          publishDate: bookDetailsModel.publishDate,
          numberOfPages: bookDetailsModel.numberOfPages,
        ),
      ],
      verify: (useCase) {
        expect(
          useCase.debugEntity,
          BookDetailsEntity(
            title: bookDetailsModel.title,
            authors: bookDetailsModel.authors,
            isbn: bookDetailsModel.isbn,
            cover: bookDetailsModel.cover,
            publishDate: bookDetailsModel.publishDate,
            numberOfPages: bookDetailsModel.numberOfPages,
          ),
        );
      },
    );
  });
}
