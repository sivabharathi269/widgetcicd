import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:widgethub/core/routing/app_router.dart';
import 'package:widgethub/core/theme/app_theme.dart';
import 'package:widgethub/core/theme/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: WidgetHubApp(),
    ),
  );
}

class WidgetHubApp extends ConsumerWidget {
  const WidgetHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'WidgetHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
