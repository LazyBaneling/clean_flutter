import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';

import 'package:clean_flutter/core/book/book_external_interface.dart';
import 'package:clean_flutter/core/book/book_request.dart';
import 'package:clean_flutter/core/book/book_success_response.dart';
import 'package:clean_flutter/features/index/presentation/index_ui.dart';
import 'package:clean_flutter/providers.dart';
import 'package:clean_flutter/routing/routes.dart';

void main() {
  testWidgets('Flow Test', (tester) async {
    final widget = AppProviderScope(
      externalInterfaceProviders: [bookExternalInterfaceProvider],
      overrides: [
        bookExternalInterfaceProvider.overrideWith(
          BookExternalInterfaceFake(),
        ),
      ],
      child: AppRouterScope(
        create: BookRouter.new,
        builder: (context) {
          return MaterialApp.router(
            routerConfig: context.router.config,
          );
        },
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.byType(IndexUI), findsOneWidget);
  });
}

class BookExternalInterfaceFake extends BookExternalInterface {
  @override
  void handleRequest() {
    on<GetBookRequest>(
      (request, send) async {
        send(
          const BookSuccessResponse(
            data: {
              "ISBN:9780980200447": {
                "title": "Slow reading",
                "authors": [
                  {"name": "John Miedema"}
                ],
                "cover": {"medium": "https://covers.openlibrary.org/b/id/5546156-M.jpg"},
                "publish_date": "March 2009",
                "number_of_pages": 92
              }
            },
          ),
        );
      },
    );
  }
}
