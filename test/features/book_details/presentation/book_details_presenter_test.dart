import 'package:clean_flutter/features/book_details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_use_case.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_presenter.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookDetailsPresenter tests |', () {
    presenterTest<BookDetailsViewModel, BookDetailsUIOutput, BookDetailsUseCase>(
      'example',
      create: (builder) => BookDetailsPresenter(builder: builder),
      overrides: [
        bookDetailsUseCaseProvider.overrideWith(BookDetailsUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.updateId('test');
      },
      expect: () => const [
        BookDetailsViewModel(id: ''),
        BookDetailsViewModel(id: 'fake-test'),
      ],
    );
  });
}

class BookDetailsUseCaseFake extends BookDetailsUseCase {
  @override
  void updateId(String id) {
    super.updateId('fake-$id');
  }
}
