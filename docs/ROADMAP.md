# ScopeGuard roadmap — phased, gate-based

## Phase 0 — Discovery and market validation
- [ ] Conduct 15–20 structured conversations (see VALIDATION).
- [ ] Competitor matrix and pricing/current alternatives.
- [ ] Clickable prototype of core flow (mobile and client web).
- [ ] Three paid pilot commitments or rethink offer.
**Gate:** validated, repeatable paid need.

## Phase 1 — Foundation
- [ ] Flutter app scaffold: Android-first; stable package identifier decided before Play release.
- [ ] Next.js approval portal skeleton.
- [ ] Supabase local development setup; environment examples.
- [ ] CI analysis/tests, dependency locking and secret scanning.
- [ ] Design tokens in light/dark and reusable core components.
- [ ] Versioned, reviewed database migrations + RLS tests.
**Gate:** clean local build and tenant isolation verified.

## Phase 2 — Professional workflow
- [ ] Auth and account deletion route.
- [ ] Client/project CRUD and baseline scope snapshots.
- [ ] Change request drafts; preview and publication.
- [ ] Manual share via native Android share sheet.
**Gate:** one complete published request from test Android device.

## Phase 3 — Client approval
- [ ] Public minimal review DTO endpoint via secured server.
- [ ] Anonymous mobile-first approval web.
- [ ] Approval/rejection transaction, immutable snapshot, append-only log.
- [ ] Expiry/revocation, idempotency, concurrency and invalid-token tests.
- [ ] Visible, accessible status/historical versions in Android.
**Gate:** safe end-to-end test with two separate test accounts/links.

## Phase 4 — Pilot
- [ ] 5–10 professionals and their actual clients, opt-in.
- [ ] Track conversion, errors, rejected/confusing proposals and repeat use.
- [ ] Threat model/privacy review, accessibility and performance.
- [ ] Iterate based on real task completion.
**Gate:** clear product value and measurable repeat behavior.

## Phase 5 — Monetization + release
- [ ] Select pricing after pilot evidence, implement correct Google Play Billing where applicable.
- [ ] Privacy policy, data safety disclosures and user data export/deletion paths.
- [ ] Play Console testing requirements appropriate to the account, verified at launch time.
- [ ] App signing, application id, screenshots, accessibility and localization QA.
- [ ] Gradual production release; monitor crashes, support and retention.
**Gate:** policy/release checks pass; no unverified compliance claims.

## Non-goals until evidence
AI features, payments collection, legal contract templates, automatic message sending, multi-user teams, white-labeling, CRM, multi-currency reporting.

## Milestone time estimates (non-binding)
Validation 1–2 weeks; engineering MVP 5–8 weeks for one developer depending on experience and UI requirements. No delivery date commitment.

## Project management
Create milestone issues only after actual implementation scope is ratified. Each implementation PR must document test evidence, schema changes and security implications.
