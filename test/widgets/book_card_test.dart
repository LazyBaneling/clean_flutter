import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter/widgets/book_card.dart';
import 'package:clean_flutter/widgets/cover_image.dart';

void main() {
  testWidgets('BookCard test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 200,
              width: 100,
              child: BookCard(
                imageUrl: 'test',
                title: 'Test Book',
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Test Book', skipOffstage: false), findsOneWidget);

    expect(find.byType(CoverImage), findsOneWidget);
  });
}
