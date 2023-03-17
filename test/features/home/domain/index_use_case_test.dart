import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:clean_flutter/features/index/domain/index_entity.dart';
import 'package:clean_flutter/features/index/domain/index_ui_output.dart';
import 'package:clean_flutter/features/index/domain/index_use_case.dart';
import 'package:clean_flutter/features/index/external_interface/book_collection_gateway.dart';
import 'package:clean_flutter/features/index/models/book_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final books = [
    BookModel(
      title: 'BOOK1',
      authors: ['Author1'],
      isbn: '1234567890',
      cover: 'https://cover.example.com/book1',
      publishDate: '2021-01-01',
      numberOfPages: 100,
    ),
    BookModel(
      title: 'BOOK2',
      authors: ['Author2'],
      isbn: '0987654321',
      cover: 'https://cover.example.com/book2',
      publishDate: '2022-01-01',
      numberOfPages: 200,
    ),
  ];

  group('IndexUseCase test |', () {
    useCaseTest<IndexUseCase, IndexEntity, IndexUIOutput>(
      'fetch Books; success',
      provider: indexUseCaseProvider,
      execute: (useCase) {
        _mockSuccess(useCase);

        return useCase.fetchBooks();
      },
      expect: () => [
        IndexUIOutput(
          books: [],
          status: IndexStatus.loading,
          isRefresh: false,
          lastViewedBook: '',
        ),
        IndexUIOutput(
          books: books,
          status: IndexStatus.loaded,
          isRefresh: false,
          lastViewedBook: '',
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
            lastViewedBook: '',
          ),
          IndexUIOutput(
            books: books,
            status: IndexStatus.loaded,
            isRefresh: false,
            lastViewedBook: '',
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
        IndexUIOutput(
          books: [],
          status: IndexStatus.loading,
          isRefresh: false,
          lastViewedBook: '',
        ),
        IndexUIOutput(
          books: [],
          status: IndexStatus.failed,
          isRefresh: false,
          lastViewedBook: '',
        ),
      ],
    );

    useCaseTest<IndexUseCase, IndexEntity, IndexUIOutput>(
'search book',
provider: indexUseCaseProvider,
seed: (e) => e.copyWith(
books: books,
status: IndexStatus.loaded,
),
execute: (useCase) {
return useCase.setInput(const BookSearchInput(title: 'book1'));
},
expect: () => [
IndexUIOutput(
books: [
BookModel(
title: 'BOOK1',
authors: ['Author1'],
isbn: '1234567890',
cover: 'https://example.com/cover1.jpg',
publishDate: '2021-01-01',
numberOfPages: 200,
),
],
status: IndexStatus.loaded,
isRefresh: false,
lastViewedBook: '',
),
],
);

useCaseBridgeTest<IndexUseCase, IndexEntity, IndexUIOutput, ProfileUseCase>(
'update last viewed book',
from: profileUseCaseProvider,
to: indexUseCaseProvider,
seed: (e) => e.copyWith(
lastViewedBook: 'Book2',
status: IndexStatus.loaded,
),
execute: (useCase) {
useCase.debugEntityUpdate((e) => e.copyWith(name: 'BOOK1'));
},
expect: () => [
IndexUIOutput(
books: [],
status: IndexStatus.loaded,
isRefresh: false,
lastViewedBook: 'BOOK1',
),
],
);

void mockSuccess(IndexUseCase useCase) {
useCase
.subscribe<BookCollectionGatewayOutput, BookCollectionSuccessInput>(
() async {
return Either.right(
BookCollectionSuccessInput(
bookIdentities: [
BookIdentity(
title: 'book1',
authors: ['Author1'],
isbn: '1234567890',
cover: 'https://example.com/cover1.jpg',
publishDate: '2021-01-01',
numberOfPages: 200,
),
BookIdentity(
title: 'book2',
authors: ['Author2'],
isbn: '0987654321',
cover: 'https://example.com/cover2.jpg',
publishDate: '2020-01-01',
numberOfPages: 300,
),
],
),
);
},
);
}

void mockFailure(IndexUseCase useCase) {
useCase
.subscribe<BookCollectionGatewayOutput, BookCollectionSuccessInput>(
() async {
return Either.left(FailureInput(message: 'No Internet'));
},
);
}
