import 'package:clean_flutter/features/details/models/book_details_model.dart';
import 'package:clean_flutter/features/index/models/book_model.dart';

final bookModel1 = BookModel(
  title: 'Example Book',
  authors: ['Author One', 'Author Two'],
  isbn: '1234567890',
  cover: 'http://example.com/cover.jpg',
  publishDate: '2007',
  numberOfPages: 100,
);

final bookModel2 = BookModel(
  title: 'Another Example Book',
  authors: ['Author Three'],
  isbn: '0987654321',
  cover: 'http://example.com/cover2.jpg',
  publishDate: '2013',
  numberOfPages: 200,
);

final bookDetailsModel = BookDetailsModel(
  title: 'Example Book',
  authors: ['Author One', 'Author Two'],
  isbn: '1234567890',
  cover: 'https://example.com/cover.jpg',
  publishDate: '2020-01-01',
  numberOfPages: 200,
);
