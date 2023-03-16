import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/common/domain/book_entity.dart';

class BookListEntity extends Entity {
  final List<BookEntity> books;

  const BookListEntity({this.books = const []});

  @override
  List<Object> get props => [books];

  @override
  BookListEntity copyWith({List<BookEntity>? books}) {
    return BookListEntity(books: books ?? this.books);
  }
}
