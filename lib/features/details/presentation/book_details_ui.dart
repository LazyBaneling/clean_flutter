import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/details/domain/book_details_ui_output.dart';
import 'package:clean_flutter/features/details/presentation/book_details_presenter.dart';
import 'package:clean_flutter/features/details/presentation/book_details_view_model.dart';
import 'package:flutter/material.dart';

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
            if (viewModel.cover != '')
              Image.network(
                viewModel.cover,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
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
