import 'package:flutter/material.dart';
import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/index/domain/index_entity.dart';
import 'package:clean_flutter/features/index/domain/index_ui_output.dart';
import 'package:clean_flutter/features/index/domain/index_use_case.dart';
import 'package:clean_flutter/features/index/presentation/index_view_model.dart';
import 'package:clean_flutter/providers.dart';

class IndexPresenter extends Presenter<IndexViewModel, IndexUIOutput, IndexUseCase> {
  IndexPresenter({
    super.key,
    required super.builder,
  }) : super(provider: indexUseCaseProvider);

  @override
  void onLayoutReady(BuildContext context, IndexUseCase useCase) {
    useCase.fetchBooks();
  }

  @override
  IndexViewModel createViewModel(IndexUseCase useCase, IndexUIOutput output) {
    return IndexViewModel(
      books: output.books,
      onRefresh: () => useCase.fetchBooks(isRefresh: true),
      onRetry: useCase.fetchBooks,
      isLoading: output.status == IndexStatus.loading,
      hasFailedLoading: output.status == IndexStatus.failed,
    );
  }

  @override
  void onOutputUpdate(BuildContext context, IndexUIOutput output) {
    if (output.isRefresh) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            output.status == IndexStatus.failed ? 'Sorry, failed refreshing books!' : 'Refreshed books successfully!',
          ),
        ),
      );
    }
  }
}
