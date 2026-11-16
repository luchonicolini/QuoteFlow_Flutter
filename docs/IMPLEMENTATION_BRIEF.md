# Coding-agent implementation brief

You are implementing **ScopeGuard** in the existing GitHub repository `luchonicolini/QuoteFlow_Flutter` (temporary repository name). Do **not** rename the remote or product to QuoteFlow. User-facing brand is ScopeGuard.

## Operating principles
1. Read `AGENTS.md` and all `docs/*` before planning changes.
2. Distinguish requirements from implemented code. The repo initially consists only of specifications.
3. Start with Phase 0 discovery artifacts and Phase 1 scaffolding; do not generate all feature code in one untested pass.
4. Product is **Android-first**; clients approve through **web**, without installing the app.
5. Design system: **Lime & Graphite** `#C5F277`, `#20231F`, `#F7F8F3`, `#E9F3DB`, `#62685B`.
6. Use Flutter/Dart for mobile, Next.js for web, Supabase for PostgreSQL/Auth/Edge Functions. Validate current dependencies and SDK versions, don't guess.
7. No service-role key in app/web browser; all authorization through vetted server functions/RLS.
8. Implement immutable published request versions and append-only approval records; test all transitions and malicious inputs.
9. Request approval is **not payment collection**, e-signature assurance or legal proof of customer identity.
10. Prevent scope creep: no AI integrations, WhatsApp scraping, automatic messages, invoicing systems or billing in MVP.

## Suggested PR sequence
PR 1 — Foundation: Flutter + Next.js skeleton, environment examples, lint/test scripts, theming, route placeholders, CI. No Supabase production access required.
PR 2 — Local Supabase schema and tests: clients/projects, baseline scope versions, RLS.
PR 3 — Auth + clients + projects UI and state/data layers.
PR 4 — Versioned change requests, snapshots, publish and share.
PR 5 — Secure review endpoint and web approval/rejection flow.
PR 6 — Hardening: concurrency, replay, token lifecycle, accessibility and end-to-end pilot readiness.
PR 7 — Paid pilot results, billing decision and Play release tasks only after validation.

## PR quality requirements
- Small, reviewable changes; no destructive migration without explicit approval.
- Document setup and local test instructions when code exists.
- No secrets committed; `.env.example` only.
- Unit tests for money/state transitions and repository permission rules.
- Integration tests for tenant isolation, token expiry, race conditions and snapshot immutability.
- Run analyzer/tests; if unavailable, state honestly and include command for verification.
- Do not insert placeholders masquerading as production functionality.
- Use Spanish copy for the first UX; structure code so translations are possible later.

## Proposed folder structure after scaffolding
```
apps/mobile/lib/
  app/
  core/
    design/
    routing/
    data/
    models/
  features/
    auth/
    clients/
    projects/
    change_requests/
    settings/
apps/approval-web/src/app/a/[token]/
supabase/migrations/
supabase/functions/
```

## Definition of done for first engineering increment
- Flutter app launches on Android emulator with Lime & Graphite light/dark tokens.
- Next.js app runs and shows a static *non-sensitive* approval mock only.
- No live approval possible until secure backend is completed.
- CI/lint/test setup works; setup is documented and reproducible.
- No backend secrets or real client data stored in repo.

## Stop conditions
If implementation requires production Supabase credentials, a destructive schema change, paid API, Play Console financial settings, or enabling a public approval endpoint, stop and request explicit owner authorization before proceeding.
