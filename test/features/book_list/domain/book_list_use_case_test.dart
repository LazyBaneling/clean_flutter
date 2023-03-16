import 'package:clean_flutter/features/book_list/domain/book_list_entity.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_ui_output.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_use_case.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/data/test_book.dart';

void main() {
  group('BookListUseCase tests |', () {
    useCaseTest<BookListUseCase, BookListEntity, BookListUIOutput>(
      'example',
      provider: bookListUseCaseProvider,
      execute: (useCase) {
        useCase.updateBooks([testBook]);
      },
      expect: () => [
        const BookListUIOutput(bookList: BookListEntity(books: [testBook])),
      ],
      verify: (useCase) {
        expect(
          useCase.debugEntity,
          const BookListEntity(books: [testBook]),
        );
      },
    );
  });
}
