import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';

import 'package:clean_flutter/features/index/domain/index_entity.dart';
import 'package:clean_flutter/features/index/domain/index_ui_output.dart';
import 'package:clean_flutter/features/index/domain/index_use_case.dart';
import 'package:clean_flutter/features/index/external_interface/book_collection_gateway.dart';
import 'package:clean_flutter/providers.dart';

import '../../../test_data.dart';

void main() {
  final books = [bookModel1, bookModel2];

  group('IndexUseCase test |', () {
    useCaseTest<IndexUseCase, IndexEntity, IndexUIOutput>(
      'fetch Books; success',
      provider: indexUseCaseProvider,
      execute: (useCase) {
        _mockSuccess(useCase);
        var f = useCase.fetchBooks();
        return f;
      },
      expect: () => [
        const IndexUIOutput(
          books: [],
          status: IndexStatus.loading,
          isRefresh: false,
        ),
        IndexUIOutput(
          books: books,
          status: IndexStatus.loaded,
          isRefresh: false,
        ),
      ],
      verify: (useCase) {
        expect(
          useCase.debugEntity,
          IndexEntity(books: books, status: IndexStatus.loaded),
        );
      },
    );

    useCaseTest<IndexUseCase, IndexEntity, IndexUIOutput>(
      'refresh Books; success',
      provider: indexUseCaseProvider,
      execute: (useCase) {
        _mockSuccess(useCase);

        return useCase.fetchBooks(isRefresh: true);
      },
      expect: () {
        return [
          IndexUIOutput(
            books: books,
            status: IndexStatus.loaded,
            isRefresh: true,
          ),
          IndexUIOutput(
            books: books,
            status: IndexStatus.loaded,
            isRefresh: false,
          ),
        ];
      },
    );

    useCaseTest<IndexUseCase, IndexEntity, IndexUIOutput>(
      'fetch Books; failure',
      provider: indexUseCaseProvider,
      execute: (useCase) {
        _mockFailure(useCase);

        return useCase.fetchBooks();
      },
      expect: () => [
        const IndexUIOutput(
          books: [],
          status: IndexStatus.loading,
          isRefresh: false,
        ),
        const IndexUIOutput(
          books: [],
          status: IndexStatus.failed,
          isRefresh: false,
        ),
      ],
    );

    useCaseTest<IndexUseCase, IndexEntity, IndexUIOutput>(
      'refresh Books; failure',
      provider: indexUseCaseProvider,
      execute: (useCase) {
        _mockFailure(useCase);

        return useCase.fetchBooks(isRefresh: true);
      },
      expect: () => [
        const IndexUIOutput(
          books: [],
          status: IndexStatus.failed,
          isRefresh: true,
        ),
        const IndexUIOutput(
          books: [],
          status: IndexStatus.loaded,
          isRefresh: false,
        ),
      ],
    );
  });
}

void _mockSuccess(IndexUseCase useCase) {
  useCase.subscribe<BookCollectionGatewayOutput, BookCollectionSuccessInput>(
    (_) async {
      return Either.right(
        BookCollectionSuccessInput(
          bookIdentities: [
            BookIdentity(
              title: bookModel1.title,
              authors: bookModel1.authors,
              isbn: bookModel1.isbn,
              cover: bookModel1.cover,
              publishDate: bookModel1.publishDate,
              numberOfPages: bookModel1.numberOfPages,
            ),
            BookIdentity(
              title: bookModel2.title,
              authors: bookModel2.authors,
              isbn: bookModel2.isbn,
              cover: bookModel2.cover,
              publishDate: bookModel2.publishDate,
              numberOfPages: bookModel2.numberOfPages,
            ),
          ],
        ),
      );
    },
  );
}

void _mockFailure(IndexUseCase useCase) {
  useCase.subscribe<BookCollectionGatewayOutput, BookCollectionSuccessInput>(
    (_) async {
      return const Either.left(FailureInput(message: 'No Internet'));
    },
  );
}
