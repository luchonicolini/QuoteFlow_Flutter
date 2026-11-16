---
name: flutter-forms-and-approval
description: Use when implementing project, client or change-request forms, preview, publishing or approval UX.
---

# Forms and Approval UX

Read `docs/USER_STORIES.md` and `docs/ARCHITECTURE.md`.

1. Define field types, required rules, money precision, input normalization and helpful error copy.
2. Keep field labels visible; validate inline without blocking all input.
3. Draft may be editable; publish requires review screen showing exact price, currency, terms and schedule impact.
4. Submitted version is immutable; revisions create a new version and invalidate superseded approval links.
5. Client web must be readable on 320px wide screens, without login, and require explicit confirmation for accept/reject.
6. Show clear expired/revoked/already-decided states; protect against duplicate actions and stale data.
7. Test screen reader, keyboard, poor connection and server failure. Never substitute a toast for persisted approval.

Do not auto-send WhatsApp messages. Invoke the native share sheet only on the professional's action.
