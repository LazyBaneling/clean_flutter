import 'package:clean_flutter/features/book_details/presentation/book_details_ui.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_view_model.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookDetailsUI tests |', () {
    uiTest<BookDetailsViewModel>(
      'example',
      ui: BookDetailsUI(),
      viewModel: const BookDetailsViewModel(id: 'test'),
      verify: (tester) async {
        expect(find.text('test'), findsOneWidget);
      },
    );
  });
}
