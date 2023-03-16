import 'package:clean_flutter/features/book_details/domain/book_details_entity.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_ui.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/data/test_book.dart';

void main() {
  group('BookDetailsUI tests |', () {
    uiTest<BookDetailsViewModel>(
      'example',
      ui: BookDetailsUI(),
      viewModel: const BookDetailsViewModel(bookDetailsEntity: BookDetailsEntity(book: testBook)),
      verify: (tester) async {
        expect(find.text(testBook.title), findsOneWidget);
      },
    );
  });
}
