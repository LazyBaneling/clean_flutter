import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/book_list/domain/book_list_ui_output.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_use_case.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_view_model.dart';
import 'package:clean_flutter/providers.dart';

class BookListPresenter extends Presenter<BookListViewModel, BookListUIOutput, BookListUseCase> {
  BookListPresenter({
    required super.builder,
    super.key,
  }) : super(provider: bookListUseCaseProvider);

  @override
  BookListViewModel createViewModel(
    BookListUseCase useCase,
    BookListUIOutput output,
  ) {
    return BookListViewModel(bookListEntity: output.bookList);
  }
}
