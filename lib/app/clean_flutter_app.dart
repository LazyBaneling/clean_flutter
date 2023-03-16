import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';
import 'package:clean_flutter/routing.dart';

class CleanFlutterApp extends StatelessWidget {
  const CleanFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProviderScope(
      child: AppRouterScope(
        create: CleanFlutterRouter.new,
        builder: (context) {
          return MaterialApp.router(
            title: 'clean_flutter',
            theme: ThemeData(
              colorSchemeSeed: Colors.blue,
              useMaterial3: true,
            ),
            routerConfig: context.router.config,
          );
        },
      ),
    );
  }
}
