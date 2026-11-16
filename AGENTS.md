# Agent operating guide — ScopeGuard

This document applies to every file in this repository, including code produced later.

## Source of truth
Read `README.md` and `docs/PRODUCT.md`, `docs/USER_STORIES.md`, `docs/DESIGN_SYSTEM.md`, `docs/ARCHITECTURE.md`, `docs/DATA_MODEL.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md` and `docs/IMPLEMENTATION_BRIEF.md` before implementation.

## Product identity
- Product: **ScopeGuard**. Temporary GitHub repo: **QuoteFlow_Flutter**. Do not rename remote or rebrand product.
- Android-first Flutter app for freelancers, web link for customer approval, Supabase backend and Next.js portal.
- Goal: prevent unpriced scope changes and document approval.
- Status: specification and validation until explicit implementation work begins.

## Design rules
- Lime `#C5F277`; graphite `#20231F`; canvas `#F7F8F3`; soft lime `#E9F3DB`; muted `#62685B`.
- Elegant restrained Material 3, dark + light themes, Manrope/Inter where licensing permits.
- Lime CTAs must use **graphite** foreground; no white on lime.
- Responsive, accessible, tested with dark mode and larger text.
- No decorative gradient, glassmorphism, repetitive SaaS cards or indiscriminate badges.

## Engineering rules
- Prefer vertical slices and small, tested pull requests; avoid speculative infrastructure.
- Flutter: feature-first, Riverpod for state, go_router for navigation. Confirm toolchain versions.
- Web: Next.js, mobile-first, minimal proposal display and no tracking on token pages.
- Backend: Supabase RLS, migrations, authenticated owner APIs; privileged server-only approval endpoints.
- Never commit tokens/keys. No service role key in browser or mobile bundle.
- Money in integer minor units and currency codes; do not sum unlike currencies.
- Immutable submitted proposals; approval/rejection atomic with append-only audit events.
- Explicit user-controlled sharing; no automated WhatsApp messaging or reading chats.
- An approval is not a payment, authenticated legal signature or proof of legal identity.
- No unreviewed destructive migrations or production deploys.

## Workflow
1. Read requirements and inspect current repo before coding.
2. Identify current phase and write a short plan.
3. Implement only current phase, with tests and failure states.
4. Run format/lint/test/build available in environment.
5. Record results and known limitations in PR/report.
6. Update docs and roadmap checkboxes only after verifying implementation.

## Out of scope for MVP
Complex CRM, fiscal billing, AI data extraction, payment processing, auto-messages, collaboration teams, advanced analytics.

## Ownership and validation
Commercial demand is not yet validated. Do not turn hypothetical pricing/research claims into assertions of confirmed demand.

## Local agent skills and dependency research
Before any Flutter implementation, inspect [docs/FLUTTER_TOOLKIT.md](docs/FLUTTER_TOOLKIT.md) and match the task to the corresponding `.agents/skills/*/SKILL.md` playbook. Use only relevant skills; don't install external scripts without reviewing source/license. Flutter libraries are **recommended**, not installed, until a real `pubspec.yaml` is created and analyzed.

## Product-grade visual quality (mandatory)
Read [docs/PRODUCT_DESIGN_QUALITY.md](docs/PRODUCT_DESIGN_QUALITY.md) before designing or implementing any screen. Treat its four-stage workflow and definition of done as acceptance criteria: product-design spec, faithful Flutter implementation, emulator screenshot comparison, accessibility/edge-state polish. Do not claim a screen is visually verified without actual evidence. The first Home mockup must be reviewed by the owner before becoming the approved reference.
