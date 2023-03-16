import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/book_details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_use_case.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/providers.dart';

class BookDetailsPresenter extends Presenter<BookDetailsViewModel, BookDetailsUIOutput, BookDetailsUseCase> {
  BookDetailsPresenter({
    required super.builder,
    super.key,
  }) : super(provider: bookDetailsUseCaseProvider);

  @override
  BookDetailsViewModel createViewModel(
    BookDetailsUseCase useCase,
    BookDetailsUIOutput output,
  ) {
    return BookDetailsViewModel(bookDetailsEntity: output.bookDetailsEntity);
  }
}
