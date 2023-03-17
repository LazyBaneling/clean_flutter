import 'package:clean_framework/clean_framework.dart';

class BookDetailsModel {
  BookDetailsModel({
    required this.title,
    required this.authors,
    required this.isbn,
    required this.cover,
    required this.publishDate,
    required this.numberOfPages,
  });

  factory BookDetailsModel.fromJson(String isbnKey, Map<String, dynamic> json) {
    final deserializer = Deserializer(json);

    return BookDetailsModel(
      title: deserializer.getString('title'),
      authors: deserializer.getList('authors', converter: (author) => author['name'] as String),
      isbn: isbnKey.substring(5), // Remove "ISBN:" prefix from the key
      cover: deserializer.getMap('cover')['medium'],
      publishDate: deserializer.getString('publish_date'),
      numberOfPages: deserializer.getInt('number_of_pages'),
    );
  }

  final String title;
  final List<String> authors;
  final String isbn;
  final String cover;
  final String publishDate;
  final int numberOfPages;
}
