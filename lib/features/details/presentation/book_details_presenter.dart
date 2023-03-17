import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/details/domain/book_details_use_case.dart';
import 'package:clean_flutter/features/details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/providers.dart';
import 'package:flutter/material.dart';

class BookDetailsPresenter extends Presenter<BookDetailsViewModel, BookDetailsUIOutput, BookDetailsUseCase> {
  BookDetailsPresenter({
    super.key,
    required super.builder,
    required this.bookId,
  }) : super(provider: bookDetailsUseCaseProvider);

  final String bookId;

  @override
  @protected
  void onLayoutReady(BuildContext context, BookDetailsUseCase useCase) {
    useCase.fetchBookDetails(bookId);
  }

  @override
  BookDetailsViewModel createViewModel(
    BookDetailsUseCase useCase,
    BookDetailsUIOutput output,
  ) {
    return BookDetailsViewModel(
      title: output.title,
      authors: output.authors,
      isbn: output.isbn,
      cover: output.cover,
      publishDate: output.publishDate,
      numberOfPages: output.numberOfPages,
    );
  }
}
