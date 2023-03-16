import 'package:clean_framework/clean_framework.dart';

class BookListUIOutput extends Output {
  const BookListUIOutput({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
