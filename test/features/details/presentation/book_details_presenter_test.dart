import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework_test/clean_framework_test.dart';

import 'package:clean_flutter/features/details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/details/domain/book_details_use_case.dart';
import 'package:clean_flutter/features/details/presentation/book_details_presenter.dart';
import 'package:clean_flutter/features/details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/providers.dart';

import '../../../test_data.dart';

void main() {
  group('BookDetailsPresenter tests |', () {
    presenterTest<BookDetailsViewModel, BookDetailsUIOutput, BookDetailsUseCase>(
      'creates proper view model',
      create: (builder) => BookDetailsPresenter(
        builder: builder,
        bookId: '123',
      ),
      overrides: [
        bookDetailsUseCaseProvider.overrideWith(BookDetailsUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            title: bookDetailsModel.title,
            authors: bookDetailsModel.authors,
            isbn: bookDetailsModel.isbn,
            cover: bookDetailsModel.cover,
            publishDate: bookDetailsModel.publishDate,
            numberOfPages: bookDetailsModel.numberOfPages,
          ),
        );
      },
      expect: () => [
        isA<BookDetailsViewModel>(),
        isA<BookDetailsViewModel>()
            .having((vm) => vm.title, 'title', bookDetailsModel.title)
            .having((vm) => vm.authors, 'authors', bookDetailsModel.authors)
            .having((vm) => vm.isbn, 'isbn', bookDetailsModel.isbn)
            .having((vm) => vm.cover, 'cover', bookDetailsModel.cover)
            .having((vm) => vm.publishDate, 'publishDate', bookDetailsModel.publishDate)
            .having((vm) => vm.numberOfPages, 'numberOfPages', bookDetailsModel.numberOfPages),
      ],
    );
  });
}

class BookDetailsUseCaseFake extends BookDetailsUseCase {
  @override
  void fetchBookDetails(String bookId) {}
}
