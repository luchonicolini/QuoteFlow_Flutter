# ScopeGuard

**Cada cambio tiene valor. Acordalo antes de trabajar.**

ScopeGuard es un producto Android-first para profesionales independientes: documenta el alcance acordado y prepara propuestas para cambios de trabajo. El cliente podrá revisar una propuesta desde un enlace web sin instalar una app.

> **Estado de implementación:** primera base técnica. La app Flutter y la maqueta web son locales y demostrativas. No hay cuentas, persistencia, envío de enlaces, backend ni aprobaciones reales.

## Estructura

```text
apps/
  mobile/          Flutter para Android (Riverpod, go_router, Material 3)
  approval-web/    Next.js con vista estática de propuesta de demostración
docs/              Requisitos, arquitectura, modelo y guía de diseño
supabase/          Reservado para migraciones y funciones en una etapa posterior
```

## Requisitos locales

- Flutter/Dart compatibles con el constraint de `apps/mobile/pubspec.yaml`.
- Node.js 22 o posterior y npm.
- Android Studio/emulador para ejecutar la app Android.

## Ejecutar la app Android

```bash
cd apps/mobile
flutter pub get
flutter run
```

La app incluye navegación inicial entre Inicio, Proyectos, Solicitudes y Perfil, tema claro/oscuro según el dispositivo y estados vacíos. Las secciones de proyectos y solicitudes todavía no guardan datos.

## Ejecutar el portal de demostración

```bash
npm ci
npm run web:dev
```

Abrí `http://localhost:3000`. La página contiene datos ficticios, está marcada como demostración y los botones de decisión están deshabilitados. **No sirve para aprobar propuestas.**

## Verificaciones

```bash
cd apps/mobile
dart format lib test
flutter analyze
flutter test
flutter build apk --debug
```

Desde la raíz:

```bash
npm run web:lint
npm run web:build
```

## Seguridad y alcance

- No hay secretos ni credenciales reales en el repositorio.
- No hay claves Supabase, políticas RLS, autenticación o endpoints todavía.
- El portal no registra eventos ni procesa tokens.
- La respuesta a una propuesta no representa un pago, una firma legal ni una verificación de identidad.
- WhatsApp, cuando se implemente, se abrirá mediante la hoja nativa de compartir del dispositivo y bajo acción del profesional.

## Próximas etapas

1. Validar las hipótesis de producto mediante entrevistas y prototipo.
2. Completar los diseños de referencia de Home en claro/oscuro y revisarlos con el propietario.
3. Incorporar pruebas, autenticación y persistencia local Supabase con aislamiento RLS.
4. Añadir clientes/proyectos y alcance base.
5. Crear versiones inmutables de solicitudes y compartir manualmente.
6. Implementar aprobación web transaccional segura con expiración, revocación y auditoría.

Seguí [docs/ROADMAP.md](docs/ROADMAP.md), [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) y [docs/PRODUCT_DESIGN_QUALITY.md](docs/PRODUCT_DESIGN_QUALITY.md) antes de ampliar el alcance.
