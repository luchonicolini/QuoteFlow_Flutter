---
name: flutter-security-and-testing
description: Use when adding Supabase models, auth, approval links, audit trails, or preparing releases.
---

# Security and Testing

Before implementation read `docs/ARCHITECTURE.md` and `docs/DATA_MODEL.md`.

- RLS on every owner-scoped table; verify tenant A cannot read/write tenant B data.
- No service-role key in Flutter or browser; server-only privileged operations.
- Public approval link uses high-entropy opaque token, stored hashed, expires and can be revoked.
- Snapshot published terms immutably; acceptance/rejection and append-only event must commit atomically.
- Test token replay, expired/revoked/superseded links, concurrent accept/reject, malicious IDs and invalid amount.
- Do not log tokens or expose them in analytics/referrers.
- Validate all inputs server side; use minimal anonymous review DTO.
- Approval is not payment or verified legal identity.
- CI must run format/analyze/tests; disclose tests not run.

Never deploy migrations, change production keys or turn on public endpoints without explicit authorization.
