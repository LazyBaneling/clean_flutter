import 'package:animations/animations.dart';
import 'package:clean_flutter/features/book_details/presentation/book_details_ui.dart';
import 'package:clean_flutter/features/book_list/presentation/book_list_ui.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:clean_flutter/routing/routes.dart';

class CleanFlutterRouter extends AppRouter<Routes> {
  @override
  RouterConfiguration configureRouter() {
    return RouterConfiguration(
      routes: [
        AppRoute(
          route: Routes.home,
          builder: (_, __) => BookListUI(),
          routes: [
            AppRoute.custom(
              route: Routes.bookDetails,
              builder: (_, state) {
                final book = state.params['book'] ?? '';
                return BookDetailsUI();
              },
              transitionsBuilder: (_, animation, secondaryAnimation, child) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
