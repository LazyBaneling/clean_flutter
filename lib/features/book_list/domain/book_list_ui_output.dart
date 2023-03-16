import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_entity.dart';

class BookListUIOutput extends Output {
  final BookListEntity bookList;

  const BookListUIOutput({required this.bookList});

  @override
  List<Object> get props => [bookList];
}
