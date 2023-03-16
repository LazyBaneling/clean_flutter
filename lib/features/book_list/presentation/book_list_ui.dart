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
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: ListView.builder(
        itemCount: viewModel.bookListEntity.books.length,
        itemBuilder: (context, index) {
          final book = viewModel.bookListEntity.books[index];
          return ListTile(
            leading: book.coverImageUrl.isNotEmpty ? Image.network(book.coverImageUrl) : const Icon(Icons.book),
            title: Text(book.title),
            subtitle: Text(book.authors.join(', ')),
            onTap: () {
              // navigate to the book details
            },
          );
        },
      ),
    );
  }
}
