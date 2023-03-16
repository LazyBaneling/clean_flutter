import 'package:clean_framework/clean_framework.dart';

class BookListViewModel extends ViewModel {
  const BookListViewModel({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
