---
name: flutter-feature-architecture
description: Use when creating Flutter features, repositories, navigation, Riverpod state or API boundaries.
---

# Flutter Feature Architecture

Use feature-first modules under `apps/mobile/lib/features/<feature>/{data,domain,presentation}`. Shared design, routing, API and value objects live in `core`. Riverpod manages async state/dependency injection; go_router handles navigation. Do not add BLoC/GetX alongside Riverpod.

## Workflow
1. Define user story and domain model first; document errors and offline behavior.
2. Add typed repository interface and implementation; never put Supabase calls inside widgets.
3. Use immutable view models and explicit loading/data/error states.
4. Handle cancellation/disposal, auth transitions and denied cross-tenant operations.
5. Add unit tests for domain rules, widget tests for screens and integration tests for API boundaries.

Money: integer minor units + ISO currency; no floating-point amount math or mixed-currency totals. Separate request draft from immutable published version. Do not claim a successful server action before it commits.
