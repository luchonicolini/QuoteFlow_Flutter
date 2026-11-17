import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/routing/app_router.dart';
import 'theme/app_theme.dart';

class ScopeGuardApp extends ConsumerWidget {
  const ScopeGuardApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'ScopeGuard',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // ScopeGuard's approved Home reference is dark-first.
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
