import 'package:flutter/material.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';

import 'package:clean_flutter/providers.dart';
import 'package:clean_flutter/routing/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviderScope(
      externalInterfaceProviders: [
        bookExternalInterfaceProvider,
      ],
      child: AppRouterScope(
        create: BookRouter.new,
        builder: (context) {
          return MaterialApp.router(
            title: 'Clean Framework Example',
            routerConfig: context.router.config,
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: ThemeMode.dark,
          );
        },
      ),
    );
  }
}
