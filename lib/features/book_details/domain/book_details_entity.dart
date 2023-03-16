import 'package:clean_framework/clean_framework.dart';

class BookDetailsEntity extends Entity {
  const BookDetailsEntity({this.id = ''});

  final String id;

  @override
  List<Object> get props => [id];

  @override
  BookDetailsEntity copyWith({String? id}) {
    return BookDetailsEntity(id: id ?? this.id);
  }
}
