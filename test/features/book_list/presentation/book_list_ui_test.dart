import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_ui.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/data/test_book.dart';

void main() {
  group('BookDetailsUI tests |', () {
    uiTest<BookDetailsViewModel>(
      'example',
      ui: BookDetailsUI(),
      viewModel: const BookDetailsViewModel(bookDetailsEntity: BookDetailsEntity(book: testBook)),
      verify: (tester) async {
        expect(find.text('Title: ${testBook.title}'), findsOneWidget);
        expect(find.text('Authors: ${testBook.authors.join(', ')}'), findsOneWidget);
        expect(find.text('Number of pages: ${testBook.numberOfPages}'), findsOneWidget);
        expect(find.text('Publish date: ${testBook.publishDate}'), findsOneWidget);
        expect(find.text('More information'), findsOneWidget);
        expect(find.byType(InkWell), findsOneWidget);
      },
    );
  });
}
