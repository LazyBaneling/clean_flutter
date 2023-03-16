import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';

class BookDetailsUIOutput extends Output {
  final BookDetailsEntity bookDetailsEntity;

  const BookDetailsUIOutput({required this.bookDetailsEntity});

  @override
  List<Object> get props => [bookDetailsEntity];
}
