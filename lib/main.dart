import 'package:avaliacao1dm3/config/dependencies.dart';
import 'package:avaliacao1dm3/routing/routing.dart';
import 'package:avaliacao1dm3/ui/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: localProviders, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      routerConfig: AppRouter.router,
    );
  }
}
