# Proposed Supabase data model v0.1 (not yet migrated)

All tables described below are **design targets**. Do not claim these tables exist. Before generating SQL, validate the relationships and write RLS/invariant tests.

| Entity | Core fields | Notes |
|---|---|---|
| profiles | id PK auth.uid, display_name, created_at, deleted_at | professional account |
| clients | id UUID, owner_id, display_name, email/phone nullable, created_at | private owner-scoped |
| projects | id UUID, owner_id, client_id, name, currency CHAR(3), original_amount_minor BIGINT, status, created_at | currency fixed on publish |
| project_scope_versions | id UUID, project_id, owner_id, version INT, included JSONB, excluded JSONB, revision_terms TEXT, created_at | immutable on publish |
| change_requests | id UUID, project_id, owner_id, title, created_at, archived_at | stable logical request |
| change_request_versions | id UUID, request_id, owner_id, version INT, terms_snapshot JSONB, amount_minor BIGINT, currency CHAR(3), schedule_impact TEXT, status, published_at, expires_at | immutable once submitted |
| approval_links | id UUID, request_version_id, token_hash, expires_at, revoked_at, created_at | token_hash unique, never raw token |
| approval_events | id UUID, request_version_id, approval_link_id, action, actor_type, decided_at, snapshot_hash, metadata JSONB | append-only |
| entitlements | owner_id, tier, valid_until, source, updated_at | post-validation only |

## Referential and uniqueness requirements
- Every child references a parent owned by the same professional. Enforce with composite keys, triggers or server checks; **RLS alone is not enough** to prevent broken cross-tenant FKs.
- `UNIQUE(request_id, version)`; `UNIQUE(project_id, version)` for scope versions.
- `CHECK(amount_minor >= 0)` and valid ISO-4217 code; use integer minor units.
- Link token hash unique; status values constrained by enum/check.
- One terminal decision for a request version; transactional unique constraint on final approval/rejection event.
- Published snapshots and decision events immutable by DB policy/trigger or deliberately restricted privileges.
- Database timestamps from trusted server clock.

## State transition graph
```
draft --publish--> pending --accept--> approved
                        |----reject--> rejected
                        |----expiry--> expired
                        |----revoke--> revoked
```
A revised request starts a new **draft version** and, after publish, supersedes prior pending links. Accepted versions remain retained as historical agreements; a new version cannot rewrite a prior acceptance.

`expired` may be derived by time comparison rather than a cron job; authoritative eligibility is always evaluated in the transaction.

## Currency display
Store amount as integer minor units and display ISO currency alongside formatted value. Avoid averaging/summing across different currencies on home dashboard. Ensure currencies with 0/3 decimals are handled using a reference table rather than assuming cents for every currency.

## Proposed data retention policy — decision required
Set retention and deletion requirements before implementing audit logs: minimum customer personal data, professional account deletion request workflow, redaction/export options, and any legal obligations. Don't adopt indefinite retention silently.

## Migration sequencing
001_auth_profiles -> 002_clients_projects -> 003_scope_versions -> 004_requests_versions -> 005_links_events -> 006_functions_rls_tests -> 007_entitlements (later).

Each migration needs reversible thinking and an explicit review for destructive actions. Do not deploy service keys, production migrations or production data modifications without authorization.
