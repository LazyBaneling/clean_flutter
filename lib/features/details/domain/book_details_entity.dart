import 'package:clean_framework/clean_framework.dart';

class BookDetailsEntity extends Entity {
  const BookDetailsEntity({
    this.title = '',
    this.authors = const [],
    this.isbn = '',
    this.cover = '',
    this.publishDate = '',
    this.numberOfPages = 0,
  });

  final String title;
  final List<String> authors;
  final String isbn;
  final String cover;
  final String publishDate;
  final int numberOfPages;

  @override
  List<Object?> get props => [title, authors, isbn, cover, publishDate, numberOfPages];

  @override
  BookDetailsEntity copyWith({
    String? title,
    List<String>? authors,
    String? isbn,
    String? cover,
    String? publishDate,
    int? numberOfPages,
  }) {
    return BookDetailsEntity(
      title: title ?? this.title,
      authors: authors ?? this.authors,
      isbn: isbn ?? this.isbn,
      cover: cover ?? this.cover,
      publishDate: publishDate ?? this.publishDate,
      numberOfPages: numberOfPages ?? this.numberOfPages,
    );
  }
}
