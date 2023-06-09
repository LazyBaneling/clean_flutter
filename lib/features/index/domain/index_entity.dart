import 'package:clean_framework/clean_framework.dart';

import 'package:clean_flutter/features/index/models/book_model.dart';

enum IndexStatus { initial, loading, loaded, failed }

class IndexEntity extends Entity {
  const IndexEntity({
    this.books = const [],
    this.bookTitleQuery = '',
    this.status = IndexStatus.initial,
    this.isRefresh = false,
  });

  final List<BookModel> books;
  final String bookTitleQuery;
  final IndexStatus status;
  final bool isRefresh;

  @override
  List<Object?> get props {
    return [books, bookTitleQuery, status, isRefresh];
  }

  @override
  IndexEntity copyWith({
    List<BookModel>? books,
    String? bookTitleQuery,
    IndexStatus? status,
    bool? isRefresh,
  }) {
    return IndexEntity(
      books: books ?? this.books,
      bookTitleQuery: bookTitleQuery ?? this.bookTitleQuery,
      status: status ?? this.status,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }
}
