import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_presenter.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsUI extends UI<BookDetailsViewModel> {
  BookDetailsUI({super.key});

  @override
  BookDetailsPresenter create(WidgetBuilder builder) => BookDetailsPresenter(builder: builder);

  @override
  Widget build(BuildContext context, BookDetailsViewModel viewModel) {
    final book = viewModel.bookDetailsEntity.book;
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.coverImageUrl.isNotEmpty) Image.network(book.coverImageUrl),
            Text('Title: ${book.title}'),
            Text('Authors: ${book.authors.join(', ')}'),
            Text('Number of pages: ${book.numberOfPages}'),
            Text('Publish date: ${book.publishDate}'),
            if (book.url.isNotEmpty)
              InkWell(
                child: const Text('More information', style: TextStyle(color: Colors.blue)),
                onTap: () => launchUrl(Uri.dataFromString(book.url)),
              ),
          ],
        ),
      ),
    );
  }
}
