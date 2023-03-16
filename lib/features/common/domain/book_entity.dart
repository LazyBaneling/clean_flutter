import 'package:clean_framework/clean_framework.dart';

class BookEntity extends Entity {
  final String id;
  final String title;
  final List<String> authors;
  final String coverImageUrl;
  final String url;
  final int numberOfPages;
  final String publishDate;

  const BookEntity({
    this.id = '',
    this.title = '',
    this.authors = const [],
    this.coverImageUrl = '',
    this.url = '',
    this.numberOfPages = 0,
    this.publishDate = '',
  });

  @override
  List<Object> get props => [id, title, authors, coverImageUrl, url, numberOfPages, publishDate];

  @override
  BookEntity copyWith({
    String? id,
    String? title,
    List<String>? authors,
    String? coverImageUrl,
    String? url,
    int? numberOfPages,
    String? publishDate,
  }) {
    return BookEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      url: url ?? this.url,
      numberOfPages: numberOfPages ?? this.numberOfPages,
      publishDate: publishDate ?? this.publishDate,
    );
  }

  factory BookEntity.fromJson(Map<String, dynamic> json) {
    final deserializer = Deserializer(json);

    return BookEntity(
      id: deserializer.getString('id'),
      title: deserializer.getString('title'),
      authors: deserializer.getSimpleList<String>('authors'),
      coverImageUrl: deserializer.getString('cover_image_url'),
      url: deserializer.getString('url'),
      numberOfPages: deserializer.getInt('number_of_pages'),
      publishDate: deserializer.getString('publish_date'),
    );
  }
}
