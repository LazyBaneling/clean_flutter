import 'package:clean_flutter/features/index/models/book_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';

class IndexViewModel extends ViewModel {
  const IndexViewModel({
    required this.books,
    required this.isLoading,
    required this.hasFailedLoading,
    required this.lastViewedBook,
    required this.onRetry,
    required this.onRefresh,
    required this.onSearch,
  });

  final List<BookModel> books;
  final bool isLoading;
  final bool hasFailedLoading;
  final String lastViewedBook;

  final VoidCallback onRetry;
  final AsyncCallback onRefresh;
  final ValueChanged<String> onSearch;

  @override
  List<Object?> get props {
    return [books, isLoading, hasFailedLoading, lastViewedBook];
  }
}
