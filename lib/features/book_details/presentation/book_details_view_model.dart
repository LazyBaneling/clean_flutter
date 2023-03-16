import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';

class BookDetailsViewModel extends ViewModel {
  const BookDetailsViewModel({required this.bookDetailsEntity});

  final BookDetailsEntity bookDetailsEntity;

  @override
  List<Object> get props => [bookDetailsEntity];
}
