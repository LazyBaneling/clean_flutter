import 'package:clean_flutter/features/book_list/domain/book_list_ui_output.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_use_case.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_presenter.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_view_model.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookListPresenter tests |', () {
    presenterTest<BookListViewModel, BookListUIOutput, BookListUseCase>(
      'example',
      create: (builder) => BookListPresenter(builder: builder),
      overrides: [
        bookListUseCaseProvider.overrideWith(BookListUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.updateId('test');
      },
      expect: () => const [
        BookListViewModel(id: ''),
        BookListViewModel(id: 'fake-test'),
      ],
    );
  });
}

class BookListUseCaseFake extends BookListUseCase {
  @override
  void updateId(String id) {
    super.updateId('fake-$id');
  }
}
