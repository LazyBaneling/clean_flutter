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
      title: deserializer.getString('title', defaultValue: 'Unknown Title'),
      authors: deserializer
          .getList('authors', converter: (author) => author['name'] as String, defaultValue: ['Unknown Author']),
      isbn: isbnKey.substring(5), // Remove "ISBN:" prefix from the key
      cover: deserializer.getMap('cover', defaultValue: {'medium': 'Not Provided'})['medium'],
      publishDate: deserializer.getString('publish_date', defaultValue: 'Not Provided'),
      numberOfPages: deserializer.getInt('number_of_pages', defaultValue: 0),
    );
  }

  final String title;
  final List<String> authors;
  final String isbn;
  final String cover;
  final String publishDate;
  final int numberOfPages;
}
