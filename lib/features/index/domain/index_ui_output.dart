import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/index/domain/index_entity.dart';
import 'package:clean_flutter/features/index/models/book_model.dart';

class IndexUIOutput extends Output {
  const IndexUIOutput({
    required this.books,
    required this.status,
    required this.isRefresh,
    required this.lastViewedBook,
  });

  final List<BookModel> books;
  final IndexStatus status;
  final bool isRefresh;
  final String lastViewedBook;

  @override
  List<Object?> get props => [books, status, isRefresh, lastViewedBook];
}
