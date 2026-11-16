# User stories and acceptance criteria

## US-01 — Account and isolation
**As a professional** I want to sign in and see only my workspace.
- A different user cannot read/write clients, projects or requests via direct database API.
- Sign-out clears protected screens. Loading, offline and error states are clear.
- Account deletion is available and documented; deletion policy covers related personal data and retention obligations.

## US-02 — Set up project terms
**As a professional** I want to document the original agreement.
- Name, currency and client are mandatory; price can be zero where appropriate.
- List what is included/excluded and revision limits; project is editable with versioning or a preserved baseline.
- Currency cannot change after a published request without explicit migration and review.

## US-03 — Draft a change request
- Title, description, price increment and schedule impact are editable in draft.
- Save locally only when clearly labeled unsynced; server must confirm persistence before publication.
- Cannot publish with invalid price, empty meaningful description or missing project.

## US-04 — Publish/preview
- Before publishing show the exact read-only customer-facing text and amounts.
- Publishing snapshots proposal version and original scope reference.
- If fields change after publication a new version is created; original version remains readable internally.

## US-05 — Share privately
- Tap Share invokes Android's native share sheet with a customer message and URL.
- The user chooses recipient and sends it manually; no WhatsApp direct-integration promise.
- Revoke disables future access/action on the link.
- Tokens are random, short-lived by default, stored hashed and never exposed to analytics or application logs.

## US-06 — Client decides without an account
- Responsive web page shows project, change, extra cost, time impact and clearly labeled decision.
- Client must explicitly confirm acceptance; reject has its own confirmation.
- Returning success page indicates a committed server state, not just a button click.
- Expired/revoked/already-decided links show clear non-sensitive messages.
- Rate limiting and one-time state transitions prevent double submissions.

## US-07 — Professional sees an audit trail
- Status and timestamp are read from server.
- Approval event references immutable proposal snapshot and agreement version.
- A detailed audit event records server timestamp, token identifier (not token raw value), request version and outcome.
- IP/device metadata is only processed if justified, disclosed and retained minimally.
- Status is not equivalent to payment confirmation.

## US-08 — Resubmission
- After rejection or material change, create an incremented request version; new link is required.
- Older links cannot accept superseded versions.
- The full sequence remains visible to the professional.

## US-09 — Accessible UX
- Keyboard/screen reader support on web; Flutter semantic labels; minimum touch targets.
- Color is not the sole indication of status; label and icon present.
- Loading, failure and retry work on poor network connections.

## US-10 — Deletion and export
- A professional can request an export of their project/request history.
- An account deletion workflow is provided before launch, with clear treatment of immutable audit snapshots, personal data and legal retention.

## Edge-case matrix
| Case | Expected |
|---|---|
| Open link after expiry | Generic expired state; no accept/reject |
| Customer taps accept twice | Exactly one decision; idempotent response |
| Client accepts while owner revokes | Database transaction resolves to one terminal outcome |
| Professional changes price after publish | New version and new token |
| Client opens older link after republish | Cannot approve stale version |
| Offline professional taps publish | Queue/draft only; no published state claimed |
| Deleted client with historical approval | Referential/legal retention policy applies; no broken audit integrity |
| Wrong user's project ID | No readable data and no mutation |
| Malicious token guessing | Rate limited and no existence disclosure |
| Multi-currency projects | No incorrect combined total |
