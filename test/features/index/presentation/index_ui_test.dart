import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework_test/clean_framework_test.dart';

import 'package:clean_flutter/features/index/presentation/index_ui.dart';
import 'package:clean_flutter/features/index/presentation/index_view_model.dart';
import 'package:clean_flutter/routing/routes.dart';
import 'package:clean_flutter/widgets/book_card.dart';

import '../../../test_data.dart';

void main() {
  group('IndexUI tests |', () {
    uiTest(
      'shows book list correctly',
      ui: IndexUI(),
      viewModel: IndexViewModel(
        books: [bookModel1, bookModel2],
        isLoading: false,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        expect(find.text(bookModel1.title), findsOneWidget);
        expect(find.text(bookModel2.title), findsOneWidget);
      },
    );

    uiTest(
      'shows loading indicator if loading data',
      ui: IndexUI(),
      viewModel: IndexViewModel(
        books: const [],
        isLoading: true,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    uiTest(
      'shows loading failed widget if data failed loading',
      ui: IndexUI(),
      viewModel: IndexViewModel(
        books: const [],
        isLoading: false,
        hasFailedLoading: true,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        expect(find.text('Oops'), findsOneWidget);
        expect(find.text('We lost the books'), findsOneWidget);
        expect(find.text('Help us, find the books'), findsOneWidget);
      },
    );

    uiTest(
      'tapping on book navigates to detail page',
      ui: IndexUI(),
      viewModel: IndexViewModel(
        books: [bookModel1, bookModel2],
        isLoading: false,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        await tester.pumpAndSettle();

        final book1CardFinder = find.descendant(
          of: find.byType(BookCard),
          matching: find.text(bookModel1.title),
        );

        expect(book1CardFinder, findsOneWidget);

        await tester.tap(book1CardFinder);
        await tester.pumpAndSettle();

        final routeData = tester.routeData!;
        expect(routeData.route, Routes.bookDetails);
        expect(routeData.params, equals({'book_id': bookModel1.isbn}));
      },
    );
  });
}
