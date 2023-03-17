import 'package:clean_flutter/core/book/hardcoded_isbns.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_flutter/core/book/book_request.dart';
import 'package:clean_flutter/core/book/book_success_response.dart';

class BookCollectionGateway extends Gateway<BookCollectionGatewayOutput, BookCollectionRequest, BookSuccessResponse,
    BookCollectionSuccessInput> {
  @override
  BookCollectionRequest buildRequest(BookCollectionGatewayOutput output) {
    return BookCollectionRequest();
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  BookCollectionSuccessInput onSuccess(BookSuccessResponse response) {
    final data = response.data;
    final List<BookIdentity> bookIdentities = [];

    for (var key in data.keys) {
      bookIdentities.add(BookIdentity.fromJson(key, data[key]));
    }

    return BookCollectionSuccessInput(bookIdentities: bookIdentities);
  }
}

class BookCollectionGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class BookCollectionSuccessInput extends SuccessInput {
  const BookCollectionSuccessInput({required this.bookIdentities});

  final List<BookIdentity> bookIdentities;
}

class BookIdentity {
  BookIdentity({
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

  factory BookIdentity.fromJson(String isbnKey, Map<String, dynamic> json) {
    final deserializer = Deserializer(json);

    return BookIdentity(
      title: deserializer.getString('title'),
      authors: deserializer.getList('authors', converter: (author) => author['name'] as String),
      isbn: isbnKey.substring(5), // Remove "ISBN:" prefix from the key
      cover: deserializer.getMap('cover')['medium'],
      publishDate: deserializer.getString('publish_date'),
      numberOfPages: deserializer.getInt('number_of_pages'),
    );
  }
}

class BookCollectionRequest extends GetBookRequest {
  @override
  String get resource => 'books';

  @override
  Map<String, dynamic> get queryParams => {
        'bibkeys': hardCodedIsbns.map((isbn) => 'ISBN:$isbn').join(','),
        'jscmd': 'data',
        'format': 'json',
      };
}
