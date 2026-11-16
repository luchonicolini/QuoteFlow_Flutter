# ScopeGuard

**Every change has value. Agree before you work.**

ScopeGuard is an **Android-first** product for independent professionals to document an agreed project scope, propose paid changes and request a client's approval through a simple mobile-friendly web link. Clients do not need to install an app.

> **Project status: discovery and implementation planning.** This repository currently contains product and engineering specifications. No Flutter application, deployed backend, approval system, payments or security controls are claimed as implemented yet.

## Product principles

1. **One core job:** turn an out-of-scope request into an explicit proposal that a client can accept or decline.
2. **WhatsApp-friendly, not WhatsApp-dependent:** the professional explicitly shares a message and link using the Android share sheet. No chat scraping or automated outreach.
3. **Client without an account:** mobile-first web review of a single proposal.
4. **Trust through precision:** submitted proposals have immutable versions; accepted terms must be preserved verbatim in an audit snapshot.
5. **Privacy by design:** private project data, minimum personal information, expiring/revocable capability links, server-side authorization.
6. **Validation first:** confirm willingness to pay before investing in automation, AI, advanced billing or a CRM.

## The ideal customer

Initial hypothesis: solo web designers, developers and creative freelancers who agree a fixed scope and receive extra requests through messaging apps. Test with real users before broadening to agencies, contractors or other verticals.

## MVP journey

1. Sign up / sign in as a professional.
2. Create a client and project with currency, baseline fee, deliverables, exclusions and revision limits.
3. Create a change request: description, fixed additional amount, expected schedule impact and optional expiry date.
4. Publish a numbered, read-only proposal version; generate a private client link.
5. Share a human-approved message through Android's native share functionality.
6. Client opens the link, views the exact proposal and accepts or rejects explicitly.
7. Professional sees the result; the server retains an append-only event and an immutable approved snapshot.
8. Any later revision creates a new version requiring new approval.

## Initial technology choices

- **Professional app:** Flutter/Dart, Android-first; Material 3, Riverpod, go_router.
- **Client portal:** Next.js mobile-first web UI.
- **Backend:** Supabase Postgres, Auth, Row Level Security and Edge Functions for privileged actions.
- **Design:** Lime & Graphite in light and dark modes; design tokens in [docs/DESIGN_SYSTEM.md](docs/DESIGN_SYSTEM.md).
- **Monetization:** pricing experiments only, not implemented; evaluate subscription vs pay-per-use and Google Play payments policy before releasing.
- **Languages:** Spanish-first UX; localization-ready architecture.

## Documentation

- [Product brief and requirements](docs/PRODUCT.md)
- [User journeys and acceptance criteria](docs/USER_STORIES.md)
- [System architecture and security](docs/ARCHITECTURE.md)
- [Data model and state machine](docs/DATA_MODEL.md)
- [Design system: Lime & Graphite](docs/DESIGN_SYSTEM.md)
- [Milestones and validation gates](docs/ROADMAP.md)
- [Engineering standards and agent instructions](AGENTS.md)
- [Flutter libraries and installed agent skills](docs/FLUTTER_TOOLKIT.md)
- [Implementation handoff for coding agents](docs/IMPLEMENTATION_BRIEF.md)
- [Research and validation plan](docs/VALIDATION.md)

## Proposed repository layout

```text
QuoteFlow_Flutter/           # Temporary GitHub repository name
├── README.md
├── AGENTS.md
├── docs/
├── apps/
│   ├── mobile/             # Flutter; created in implementation phase
│   └── approval-web/       # Next.js; created in implementation phase
├── supabase/
│   ├── migrations/         # Versioned SQL migrations
│   └── functions/          # Secure approval endpoints
└── .github/workflows/      # CI once runnable apps exist
```

Do not interpret the proposed paths as existing executable code.

## Development order

**Validation → design and threat model → Flutter skeleton → project/scope CRUD → versioned change requests → secure client approval portal → audit and tests → pilot → Google Play readiness.**

Current owner repository: [luchonicolini/QuoteFlow_Flutter](https://github.com/luchonicolini/QuoteFlow_Flutter). The repository can be renamed later without changing the product requirements.

## Not in MVP

Automatic WhatsApp messaging, accounting or tax invoices, Stripe or Mercado Pago collection, AI extraction of private chats, team collaboration, contract enforceability guarantees, and complex CRM dashboards.

## Safety note

A link-based acceptance is evidence of an interaction, **not** proof of the customer's legal identity or guaranteed legal enforceability. Identity assurance and applicable law require separate assessment.
