import 'package:clean_framework/clean_framework.dart';

class BookListEntity extends Entity {
  const BookListEntity({this.id = ''});

  final String id;

  @override
  List<Object> get props => [id];

  @override
  BookListEntity copyWith({String? id}) {
    return BookListEntity(id: id ?? this.id);
  }
}
