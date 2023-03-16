import 'package:clean_framework/clean_framework.dart';

class BookDetailsUIOutput extends Output {
  const BookDetailsUIOutput({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
