import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:clean_flutter/routing/routes.dart';
import 'package:flutter/material.dart';

class CleanFlutterRouter extends AppRouter<Routes> {
  @override
  RouterConfiguration configureRouter() {
    return RouterConfiguration(
      routes: [
        AppRoute(
          route: Routes.home,
          builder: (_, __) => const Placeholder(),
        ),
      ],
    );
  }
}