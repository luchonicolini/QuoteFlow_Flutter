import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scopeguard/app/app.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('ScopeGuardApp widget smoke test', () {
    testWidgets('renders benchmark home screen elements matching design', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.625;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ProviderScope(child: ScopeGuardApp()));
      await tester.pumpAndSettle();

      expect(find.text('ScopeGuard'), findsOneWidget);
      expect(find.textContaining('Luciano'), findsOneWidget);
      expect(find.text('Proyectos activos'), findsOneWidget);
      expect(find.text('Estudio Norte'), findsOneWidget);
      expect(find.text('Inicio'), findsOneWidget);
      expect(find.text('Proyectos'), findsWidgets);
      expect(find.text('Cambios'), findsOneWidget);
      expect(find.text('Perfil'), findsOneWidget);

      // Scroll to verify lower items in the scrollable view
      final ctaFinder = find.text('Nueva solicitud de cambio');
      await tester.scrollUntilVisible(
        ctaFinder,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(ctaFinder, findsOneWidget);
    });

    testWidgets('renders benchmark profile screen elements matching design', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.625;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ProviderScope(child: ScopeGuardApp()));
      await tester.pumpAndSettle();

      // Tap on Perfil tab
      await tester.tap(find.text('Perfil'));
      await tester.pumpAndSettle();

      expect(find.text('Luciano'), findsOneWidget);
      expect(find.text('👑 Plan Pro'), findsOneWidget);
      expect(find.text('luciano@nicolini.dev'), findsOneWidget);
      expect(find.text('Proyectos'), findsWidgets);
      expect(find.text('Cambios'), findsWidgets);
      expect(find.text('Rentabilidad'), findsOneWidget);
      expect(find.text('Configuración'), findsOneWidget);
      expect(find.text('Información personal'), findsOneWidget);
      expect(find.text('Notificaciones'), findsOneWidget);
      expect(find.text('Apariencia'), findsOneWidget);
      expect(find.text('Seguridad'), findsOneWidget);
      expect(find.text('Ayuda y soporte'), findsOneWidget);
      expect(find.text('Cerrar sesión'), findsOneWidget);
    });

    testWidgets('renders benchmark projects screen with search and filters', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.625;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ProviderScope(child: ScopeGuardApp()));
      await tester.pumpAndSettle();

      // Tap on Proyectos tab in the bottom bar
      await tester.tap(find.text('Proyectos').last);
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Gestioná y hacé seguimiento'),
        findsOneWidget,
      );
      expect(find.text('Buscar proyecto...'), findsOneWidget);
      expect(find.text('Activos'), findsOneWidget);
      expect(find.text('Finalizados'), findsOneWidget);
      expect(find.text('Pausados'), findsOneWidget);
      expect(find.text('Estudio Norte'), findsOneWidget);
      expect(find.text('Hotel Intermonti'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Nuevo proyecto'),
        180,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Nuevo proyecto'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Fintech Nova'),
        180,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Fintech Nova'), findsOneWidget);
    });
  });
}
