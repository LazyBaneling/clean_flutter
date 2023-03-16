import 'package:clean_flutter/features/book_list/presentation/book_list_ui.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_view_model.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookListUI tests |', () {
    uiTest<BookListViewModel>(
      'example',
      ui: BookListUI(),
      viewModel: const BookListViewModel(id: 'test'),
      verify: (tester) async {
        expect(find.text('test'), findsOneWidget);
      },
    );
  });
}
