import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_presenter.dart';

class BookDetailsUI extends UI<BookDetailsViewModel> {
  BookDetailsUI({super.key});

  @override
  BookDetailsPresenter create(WidgetBuilder builder) => BookDetailsPresenter(builder: builder);

  @override
  Widget build(BuildContext context, BookDetailsViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Text(viewModel.id),
      ),
    );
  }
}