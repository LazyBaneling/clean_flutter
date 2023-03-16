import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/book_list/domain/book_list_entity.dart';

class BookListViewModel extends ViewModel {
  final BookListEntity bookListEntity;

  const BookListViewModel({required this.bookListEntity});

  @override
  List<Object> get props => [bookListEntity];
}
