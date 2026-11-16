# Flutter libraries & agent skills — vetted shortlist (2026-11-16)

This is a **selection guide**, not a claim that packages are installed. There is no Flutter `pubspec.yaml` yet. Check SDK constraints, licensing, latest stable versions, platform support and maintenance before adding dependencies. Use `flutter pub add` in the Flutter app when scaffolding.

## Recommended MVP dependencies

| Need | Package | Priority | Notes |
|---|---|---|---|
| State management and DI | [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) | Core | Keep async/business logic out of widgets |
| Navigation/deep links | [go_router](https://pub.dev/packages/go_router) | Core | Typed route patterns and auth redirects |
| Supabase Auth/database | [supabase_flutter](https://pub.dev/packages/supabase_flutter) | Core when backend starts | Use RLS; never ship service role credentials |
| Internationalized dates/money | [intl](https://pub.dev/packages/intl) | Core | Format from ISO currency and integer minor units |
| Fonts | [google_fonts](https://pub.dev/packages/google_fonts) | Optional | Manrope + Inter; bundle licensed assets for predictable offline experience |
| Color schemes | [flex_color_scheme](https://pub.dev/packages/flex_color_scheme) | Evaluate | Useful for light/dark theme; check Flutter SDK compatibility **before installing**; v9 requires Flutter 3.47+ |
| Native sharing | [share_plus](https://pub.dev/packages/share_plus) | Core when share implemented | Manual Android share sheet |
| Immutable models | [freezed](https://pub.dev/packages/freezed) + [json_serializable](https://pub.dev/packages/json_serializable) | Evaluate | Useful once models stabilize; adds code generation |
| Lints | [very_good_analysis](https://pub.dev/packages/very_good_analysis) | Recommended dev | Align with team/toolchain and avoid duplicate lint rules |
| Test helpers | [mocktail](https://pub.dev/packages/mocktail) | Recommended dev | Prefer small fake repositories where possible |
| Visual regression | [golden_toolkit](https://pub.dev/packages/golden_toolkit) or Flutter built-in golden tests | Evaluate | Verify compatibility/maintenance; don't assume package is required |
| Motion | [flutter_animate](https://pub.dev/packages/flutter_animate) | Later | Only purposeful 150–250ms transitions; honor reduced motion |
| SVG icons | [flutter_svg](https://pub.dev/packages/flutter_svg) | Optional | Only if custom icons truly need SVG; standard Material icons first |
| Persistent preferences | [shared_preferences](https://pub.dev/packages/shared_preferences) | Optional | Theme preference only; **not** secure secrets |
| Secure secrets | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) | Evaluate | Only if auth SDK doesn't already manage session securely |
| Local database | [drift](https://pub.dev/packages/drift) | Later | Add only if offline drafts become a validated requirement |

**Avoid unnecessary packages:** GetX/BLoC alongside Riverpod, broad UI kits that override our design tokens, large animation frameworks for static forms, AI SDKs before validation, direct WhatsApp automation packages and unmaintained dependencies.

## Agent skills installed locally in this repository

Skills are project-owned Markdown playbooks, **not executable dependencies or copied third-party code**:

- [flutter-design-system](../.agents/skills/flutter-design-system/SKILL.md): Lime & Graphite design tokens and reusable components.
- [flutter-feature-architecture](../.agents/skills/flutter-feature-architecture/SKILL.md): feature-first Riverpod/go_router architecture.
- [flutter-forms-and-approval](../.agents/skills/flutter-forms-and-approval/SKILL.md): request forms, immutable publish and web approval.
- [flutter-visual-qa](../.agents/skills/flutter-visual-qa/SKILL.md): emulator screenshots, golden tests and accessibility.
- [flutter-security-and-testing](../.agents/skills/flutter-security-and-testing/SKILL.md): Supabase RLS, public token threats and tests.

Agent instructions: inspect `.agents/skills/*/SKILL.md` and activate only skills relevant to the task. These are tailored project playbooks written for ScopeGuard, not exact copies of external repositories.

## External skill references reviewed

- [Flutter contributor Agent Skills](https://github.com/flutter/flutter/tree/master/.agents/skills): official upstream patterns.
- [TheSimpleApp/flutter-app-skills](https://github.com/TheSimpleApp/flutter-app-skills): custom design systems, forms, accessibility.
- [ChunkyTofuStudios/flutter-skills](https://github.com/ChunkyTofuStudios/flutter-skills): emulator and design polish workflow.
- [zakariaf/Flutter-Skills](https://github.com/zakariaf/Flutter-Skills): broader Riverpod, testing, navigation and release patterns.

**Security:** don't bulk-install remote skills or execute unknown scripts. Review license, commands and requested permissions first. The five included skills contain guidance only and no executable third-party scripts.

## Setup order for coding agent

1. Check installed Flutter/Dart SDK, choose compatible dependency versions and commit `pubspec.lock` for reproducible app builds.
2. Scaffold Android app and build centralized `AppTheme` / `AppColors` before feature screens.
3. Implement simple navigation and reusable UI primitives.
4. Add Riverpod, go_router, tests and CI; only add Supabase when starting real persistence.
5. Evaluate FlexColorScheme compatibility and design fidelity; use native ThemeData if package introduces unwanted styling or SDK constraints.
6. Capture screenshots from emulator and review against approved screens before merging.
