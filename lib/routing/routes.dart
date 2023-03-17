import 'package:animations/animations.dart';
import 'package:clean_flutter/features/index/presentation/index_ui.dart';
import 'package:clean_flutter/features/details/presentation/book_details_ui.dart';
import 'package:clean_framework_router/clean_framework_router.dart';

enum Routes with RoutesMixin {
  home('/'),
  bookDetails(':book_id');

  const Routes(this.path);

  @override
  final String path;
}

class BookRouter extends AppRouter<Routes> {
  @override
  RouterConfiguration configureRouter() {
    return RouterConfiguration(
      routes: [
        AppRoute(
          route: Routes.home,
          builder: (_, __) => IndexUI(),
          routes: [
            AppRoute.custom(
              route: Routes.bookDetails,
              builder: (_, state) {
                return BookDetailsUI(
                  bookId: state.params['book_id'] ?? '',
                );
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
