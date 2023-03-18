import 'package:flutter/foundation.dart';
import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/index/models/book_model.dart';

class IndexViewModel extends ViewModel {
  const IndexViewModel({
    required this.books,
    required this.isLoading,
    required this.hasFailedLoading,
    required this.onRetry,
    required this.onRefresh,
  });

  final List<BookModel> books;
  final bool isLoading;
  final bool hasFailedLoading;

  final VoidCallback onRetry;
  final AsyncCallback onRefresh;

  @override
  List<Object?> get props {
    return [books, isLoading, hasFailedLoading];
  }
}
