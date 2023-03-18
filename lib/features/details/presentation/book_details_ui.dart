import 'package:flutter/material.dart';
import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/details/presentation/book_details_presenter.dart';
import 'package:clean_flutter/features/details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/widgets/cover_image.dart';

class BookDetailsUI extends UI<BookDetailsViewModel> {
  BookDetailsUI({super.key, required this.bookId});

  final String bookId;

  @override
  BookDetailsPresenter create(WidgetBuilder builder) {
    return BookDetailsPresenter(builder: builder, bookId: bookId);
  }

  @override
  Widget build(BuildContext context, BookDetailsViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: CoverImage(imageUrl: viewModel.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    viewModel.authors.join(', '),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('ISBN: ${viewModel.isbn}'),
                  Text('Published: ${viewModel.publishDate}'),
                  Text('Number of pages: ${viewModel.numberOfPages}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
