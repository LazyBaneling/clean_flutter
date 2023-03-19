import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework_test/clean_framework_test.dart';

import 'package:clean_flutter/features/details/presentation/book_details_ui.dart';
import 'package:clean_flutter/features/details/presentation/book_details_view_model.dart';
import 'package:clean_flutter/widgets/cover_image.dart';

void main() {
  group('BookDetailsUI tests |', () {
    uiTest<BookDetailsViewModel>(
      'shows book details correctly',
      ui: BookDetailsUI(bookId: '1'),
      viewModel: const BookDetailsViewModel(
        title: 'The Great Gatsby',
        authors: ['F. Scott Fitzgerald'],
        isbn: '9780743273565',
        cover: 'https://example.com/cover.jpg',
        publishDate: 'April 10, 1925',
        numberOfPages: 180,
      ),
      verify: (tester) async {
        await tester.pumpAndSettle();

        expect(find.text('The Great Gatsby'), findsNWidgets(2));
        expect(find.text('F. Scott Fitzgerald'), findsOneWidget);
        expect(find.text('ISBN: 9780743273565'), findsOneWidget);
        expect(find.text('Published: April 10, 1925'), findsOneWidget);
        expect(find.text('Number of pages: 180'), findsOneWidget);

        final coverFinder = find.byType(CoverImage);
        expect(coverFinder, findsOneWidget);
      },
    );
  });
}
