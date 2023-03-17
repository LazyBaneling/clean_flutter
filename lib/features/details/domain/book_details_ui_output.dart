import 'package:clean_framework/clean_framework.dart';

class BookDetailsUIOutput extends Output {
  const BookDetailsUIOutput({
    required this.title,
    required this.authors,
    required this.isbn,
    required this.cover,
    required this.publishDate,
    required this.numberOfPages,
  });

  final String title;
  final List<String> authors;
  final String isbn;
  final String cover;
  final String publishDate;
  final int numberOfPages;

  @override
  List<Object?> get props => [title, authors, isbn, cover, publishDate, numberOfPages];
}
