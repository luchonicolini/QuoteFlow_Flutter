# Technical architecture & threat model — proposal v0.1

## Boundaries
```
Flutter Android (authenticated professional)
        | Supabase Auth session
        v
Supabase/PostgreSQL (RLS owner-scoped data)
        ^
        | privileged Edge Functions, service role server-side ONLY
        |
Next.js approval portal (anonymous, token-based public request)
```

Only the public proposal endpoint is anonymous. It must return a **minimal presentation DTO**, never a raw joined SQL record. **Never use a service role credential in Flutter or browser JavaScript.**

## Monorepo direction
- `apps/mobile`: Flutter app, feature-first modules (auth, projects, requests, settings), Riverpod state, go_router and typed repositories.
- `apps/approval-web`: Next.js App Router, server handlers for read/approve/reject; no PII in metadata. No broad privileged data fetch in the client.
- `supabase/migrations`: additive, reviewed SQL migrations, RLS, constraints and indexes.
- `supabase/functions`: trusted operations when database transaction authorization can't be safely expressed client-side.
- `docs`: normative product, security and design contracts.

## Security invariants
1. RLS enabled on all business tables; owner identity derived from `auth.uid()`, never a request-provided owner ID.
2. Public anonymous operations use token-based endpoints with hashed, high-entropy tokens and constant-time comparisons where applicable; secret token is never stored as plain text.
3. Database transaction/locked row provides a single accepted/rejected terminal action; old links become invalid after a revised version.
4. Published proposal is an immutable snapshot (amount in minor units, ISO currency, deliverables, schedule impact, baseline terms version, template/text version).
5. Event log is append-only by DB rule; no mobile client INSERT to approval events. Only privileged server routines write terminal events.
6. State change and audit insertion are one transaction. A successful response is only sent after commit.
7. Owner can revoke links. Expiration and revocation are enforced server side.
8. Restrict CORS to required origins, apply endpoint rate limits; do not index approval URLs; enforce `Referrer-Policy: no-referrer`, `Cache-Control: no-store`, `X-Robots-Tag: noindex`.
9. Avoid third-party scripts, external images, analytics and public file storage on token-bearing pages; sensitive tokens must not appear in error logs.
10. Do not claim e-signature compliance or verified legal identity. A shared link can be forwarded.

## Approval flow (draft)
1. Authenticated owner publishes version via authorized server operation.
2. Server snapshots version and generates 256-bit random token; stores SHA-256 hash, expiry and version reference.
3. Owner obtains shareable link once. Consider recovery/rotation without raw token storage.
4. Client GET uses token to retrieve only safe review DTO (no owner contact unless intentionally shared).
5. Client POST includes token + desired decision and explicit user confirmation. Server checks status, token, expiry, version and revocation atomically.
6. Server commits terminal decision + append-only event + immutable snapshot reference.
7. Owner sees server-confirmed state; optional notifications later.

**Threats:** leaked/forwarded URLs, guessable URLs, replay/double accept, link preview bots, cross-tenant access, altered published terms, token exposure to third parties, denial-of-service and mistaken customer identity.

**Mitigations:** token entropy/hash/expiry, confirmation POST, transaction constraints, owner authorization, privacy headers, throttling, tamper resistant event history, clear disclosure of identity limitations.

## App boundaries
Use shared value objects for `Money`, `Currency`, `ProjectScope`, `RequestVersion`, and `RequestStatus`. The portal and mobile app must use compatible API contracts, ideally generated from a schema. Backend computes authoritative totals and statuses; do not trust client-computed money.

## Release readiness
- Automated RLS cross-tenant tests (including anonymous role).
- Concurrent acceptance/revocation tests.
- Static analysis and dependency review.
- Local/emulator end-to-end approved/rejected flow.
- Manual security review of public routes and secrets.
- Privacy policy, data safety form, account deletion, appropriate Google Play payment integration where relevant.
