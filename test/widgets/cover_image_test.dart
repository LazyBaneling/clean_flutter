import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter/widgets/cover_image.dart';

void main() {
  testWidgets('CoverImage displays a valid image', (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CoverImage(imageUrl: imageUrl),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(Icon), findsNothing);
  });

  testWidgets('CoverImage displays a placeholder for an invalid image URL', (WidgetTester tester) async {
    const imageUrl = 'invalid_image_url';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CoverImage(imageUrl: imageUrl),
        ),
      ),
    );

    expect(find.byType(Image), findsNothing);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(Icons.book), findsOneWidget);
  });
}
