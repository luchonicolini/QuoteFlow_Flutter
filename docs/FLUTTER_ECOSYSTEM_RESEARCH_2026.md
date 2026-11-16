# Flutter ecosystem research — November 2026

Status: research and integration backlog, **not installed dependencies**. The initial Flutter scaffold is not yet present. Trends are directional, not guarantees of quality.

## Evidence and selection

- Flutter official announcement (May 2026): https://flutter.dev/blog/introducing-skills-for-dart-and-flutter — official task-oriented Flutter and Dart agent skills.
- Flutter contributor guidance: https://github.com/flutter/flutter/blob/master/.agents/skills/README.md — skill conventions, examples and validation.
- Open-source ecosystem sample: https://itsallwidgets.com/stats — 666 readable pubspec.yaml files; Riverpod in newer cohorts 2%→11%, go_router 2%→6%, Dio 8%→14%. **Convenience sample, not market-wide adoption.**
- Download-based package rankings: https://fluttertrends.dev/top/ — go_router, dio, flutter_riverpod, share_plus, google_fonts, freezed and json_serializable among widely downloaded packages. Download counts include CI and transitive dependencies and should not be mistaken for distinct apps.

## Official skills to evaluate first

Upstream:
- https://github.com/flutter/skills
- https://github.com/dart-lang/skills

Prioritize official skills for:
- Responsive/adaptive Flutter layout.
- Flutter integration test setup.
- Flutter localization setup.
- Dart pattern matching and modern idioms.
- Dart test coverage.

**Install policy:** Inspect upstream `SKILL.md`, licensing, scripts, dependencies and requested permissions. Select only needed skills; avoid bulk-installing everything. Prefer official skills as upstream references and keep project-specific playbooks in `.agents/skills/`. Verify discovery in the actual coding agent (Codex/Antigravity).

The official announcement documents a skills CLI approach, but never run unreviewed `npx` commands automatically in CI or on production machines.

## Libraries / tooling to evaluate

| Tool | Why | Decision |
|---|---|---|
| flutter_riverpod | async state, dependency injection | Adopt in scaffold |
| go_router | declarative routes and auth redirects | Adopt in scaffold |
| freezed + json_serializable | immutable typed domain models | Add once domain models stabilize |
| dio | advanced HTTP clients/interceptors | Conditional; Supabase SDK may suffice |
| Widgetbook (https://pub.dev/packages/widgetbook) | component catalog, UI state review | Evaluate for design-heavy screens |
| Flutter built-in golden tests | UI regression for Lime & Graphite | Adopt basic golden tests |
| Patrol (https://pub.dev/packages/patrol) | device integration test workflows | Evaluate for approval/share flows |
| flutter_animate | subtle transitions | Optional after UX review |
| Shorebird (https://shorebird.dev/) | code push / release operations | Post-MVP; policy and compatibility review |
| flutter_launcher_icons | repeatable app icons | Release preparation |
| flutter_native_splash | launch screen generation | Release preparation |
| very_good_analysis | strict linting | Evaluate vs flutter_lints, choose one |
| melos (https://pub.dev/packages/melos) | monorepo scripts | Only if Flutter/Dart package count justifies it |
| dart_mappable / alternatives | model serialization | Do not add alongside Freezed without specific need |

Do not add Bloc/GetX alongside Riverpod, auto_route alongside go_router, multiple overlapping animation frameworks, or a second HTTP stack without evidence.

## ScopeGuard integration order

**Now — agent workflow:** review official Flutter/Dart skills; add the few relevant skills with provenance and tests; verify agent can find and use them.

**Phase 1 — app skeleton:** Flutter SDK compatibility check; Riverpod, go_router, intl, linting, design tokens, widget/golden tests; assess Widgetbook only if it saves review time.

**Phase 2 — persistence:** Supabase Flutter, Freezed/json_serializable if warranted, RLS tests; Dio only if an external REST integration arises.

**Phase 3 — sharing and approval:** share_plus, web portal and device integration testing; consider Patrol if native share interactions need automation.

**Phase 4 — polish:** flutter_animate and Widgetbook for proven UI needs, visual QA screenshots, accessibility.

**Release:** launcher icons/splash, CI, crash reporting after privacy review, optional Shorebird only after assessing Google Play and deployment constraints.

## Acceptance
- Compatibility and license reviewed for each chosen package.
- Dependencies only added when code uses them; lockfile committed.
- `flutter analyze`, `flutter test` and relevant integration tests pass.
- Skills validated in agent environment; source/provenance recorded.
- No unreviewed external scripts or production deployments.
