import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/index/presentation/index_presenter.dart';
import 'package:clean_flutter/features/index/presentation/index_view_model.dart';
import 'package:clean_flutter/routing/routes.dart';
import 'package:clean_flutter/widgets/book_card.dart';
import 'package:clean_flutter/widgets/book_search_field.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';

class IndexUI extends UI<IndexViewModel> {
  IndexUI({Key? key}) : super(key: key);

  @override
  IndexPresenter create(WidgetBuilder builder) {
    return IndexPresenter(builder: builder);
  }

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;

    Widget child;
    if (viewModel.isLoading) {
      child = const Center(child: CircularProgressIndicator());
    } else if (viewModel.hasFailedLoading) {
      child = _LoadingFailed(onRetry: viewModel.onRetry);
    } else {
      child = RefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: ListView.builder(
          prototypeItem: const SizedBox(height: 176), // 160 + 16
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final book = viewModel.books[index];

            return BookCard(
              key: ValueKey(book.title),
              imageUrl: book.cover,
              title: book.title,
              onTap: () {
                context.router.go(
                  Routes.bookDetails,
                  params: {'book_id': book.isbn},
                  queryParams: {'image': book.cover},
                );
              },
              heroTag: book.isbn,
            );
          },
          itemCount: viewModel.books.length,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        centerTitle: false,
        titleTextStyle: textTheme.displaySmall!.copyWith(
          fontWeight: FontWeight.w300,
        ),
        bottom:
            viewModel.isLoading || viewModel.hasFailedLoading ? null : BookSearchField(onChanged: viewModel.onSearch),
      ),
      body: child,
    );
  }
}

class _LoadingFailed extends StatelessWidget {
  const _LoadingFailed({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text(
            'Oops',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          const Text('We lost the books'),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('Help us, find the books'),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
