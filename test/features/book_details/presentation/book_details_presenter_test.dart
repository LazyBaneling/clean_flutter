import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_use_case.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_presenter.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/features/common/domain/book_entity.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/data/test_book.dart';

void main() {
  group('BookDetailsPresenter tests |', () {
    presenterTest<BookDetailsViewModel, BookDetailsUIOutput, BookDetailsUseCase>(
      'example',
      create: (builder) => BookDetailsPresenter(builder: builder),
      overrides: [
        bookDetailsUseCaseProvider.overrideWith(BookDetailsUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.updateBook(testBook);
      },
      expect: () => [
        const BookDetailsViewModel(
            bookDetailsEntity: BookDetailsEntity(book: BookEntity())), // Default ViewModel with an empty BookEntity
        BookDetailsViewModel(bookDetailsEntity: BookDetailsEntity(book: testBook.copyWith(id: 'fake-test'))),
      ],
    );
  });
}

class BookDetailsUseCaseFake extends BookDetailsUseCase {
  @override
  void updateBook(BookEntity book) {
    super.updateBook(book.copyWith(id: 'fake-${book.id}'));
  }
}
