import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'package:clean_flutter/features/book_list/presentation/book_list_view_model.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_presenter.dart';

class BookListUI extends UI<BookListViewModel> {
  BookListUI({super.key});

  @override
  BookListPresenter create(WidgetBuilder builder) => BookListPresenter(builder: builder);

  @override
  Widget build(BuildContext context, BookListViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Text(viewModel.id),
      ),
    );
  }
}