import 'package:clean_flutter/features/book_list/domain/book_list_entity.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_ui_output.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_use_case.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_presenter.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_view_model.dart';
import 'package:clean_flutter/features/common/domain/book_entity.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/data/test_book.dart';

void main() {
  group('BookListPresenter tests |', () {
    presenterTest<BookListViewModel, BookListUIOutput, BookListUseCase>(
      'example',
      create: (builder) => BookListPresenter(builder: builder),
      overrides: [
        bookListUseCaseProvider.overrideWith(BookListUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.updateBooks([testBook]);
      },
      expect: () => [
        const BookListViewModel(bookListEntity: BookListEntity(books: [])),
        const BookListViewModel(bookListEntity: BookListEntity(books: [testBook])),
      ],
    );
  });
}

class BookListUseCaseFake extends BookListUseCase {
  @override
  void updateBooks(List<BookEntity> books) {
    super.updateBooks([testBook]);
  }
}
