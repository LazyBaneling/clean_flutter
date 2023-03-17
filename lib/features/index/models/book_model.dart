
class BookModel {
  BookModel({
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          authors == other.authors &&
          isbn == other.isbn &&
          cover == other.cover &&
          publishDate == other.publishDate &&
          numberOfPages == other.numberOfPages;

  @override
  int get hashCode =>
      title.hashCode ^
      authors.hashCode ^
      isbn.hashCode ^
      cover.hashCode ^
      publishDate.hashCode ^
      numberOfPages.hashCode;
}
