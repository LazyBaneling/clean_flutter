import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/common/domain/book_entity.dart';

class BookDetailsEntity extends Entity {
  final BookEntity book;

  const BookDetailsEntity({required this.book});

  @override
  List<Object> get props => [book];

  @override
  BookDetailsEntity copyWith({BookEntity? book}) {
    return BookDetailsEntity(book: book ?? this.book);
  }
}
