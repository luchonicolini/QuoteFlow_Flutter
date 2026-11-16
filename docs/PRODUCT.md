# ScopeGuard — Product specification v0.1

## Status
Hypothesis under validation. These requirements are **proposed**, not proven user needs. Do not build monetization or automation until a validation gate is met.

## Problem
Freelancers agree a fixed scope and price, then receive informal additional requests (often by WhatsApp). They sometimes complete these extras without recording or charging for them.

## Positioning
**"Cada cambio tiene un valor. Acordalo antes de trabajar."**
A focused tool to propose and document client-approved extra work, not a generic invoicing, project management or legal contracting platform.

## Audience
Primary: solo web developers, web designers, visual designers and video editors selling fixed-fee projects. Secondary audiences only after interviewing them.

## Job to be done
"When my client asks for work beyond what we agreed, help me describe the change, explain the extra cost and obtain a clear decision without making the relationship awkward."

## Core scope
- Account: email authentication, profile and data deletion.
- Clients: name and optional contact, minimizing PII.
- Projects: name, client, currency, agreed baseline fee, start/end dates (optional), description and status.
- Baseline scope: included deliverables, exclusions, and revision policy, stored as versioned terms.
- Requests: additional work, pricing in minor units, optional time extension, expiration, draft/submit/approve/reject lifecycle.
- Link: per submitted version, secure opaque token; share via Android share sheet to WhatsApp or other apps.
- Client web: readable proposal summary, full terms, clear accept/decline controls, explicit confirmation, privacy notice. Accessible and responsive.
- Timeline: append-only events for submit, view (only with privacy review), approve, reject, expire and revoke.
- Notifications: app refresh and simple status display; no push requirement for MVP.
- Locale: Spanish first; currency formatting independent of storage.

## MVP screen map (Android)
1. Welcome/sign-in (no marketing-heavy onboarding).
2. Home: actionable pending requests, ongoing projects and approved extras; never mix currencies into a single total.
3. Project list with create action.
4. Project create/edit: client, fee, currency, inclusions and exclusions.
5. Project detail: original scope and change history.
6. Change request editor + preview.
7. Request detail: current version, link share/revoke, events/status.
8. Profile/settings: account, privacy, default currency, theme, help.

Web routes (proposed): `/a/[token]` review and `/a/[token]/result` confirmation. Never expose customer private information or token values in analytics, URL previews, logs or referrers.

## Important rules
- Initial fixed-fee estimate is not an automatic bill and an approved change is not a paid invoice.
- No extra work starts until explicit approval in the intended workflow.
- A proposal with material changes is a **new immutable version**. Old approval links become unusable for acceptance.
- Currency is fixed per project in MVP; totals are calculated only in that currency.
- Amounts use integer minor units (e.g., cents), not floating-point.
- Client name is not identity verification. Record what happened without promising legal enforceability.
- Acceptance must be intentional, with an explicit checkbox/confirmation and no prechecked consent.
- A draft may be edited. A published/approved version may not.
- A rejection does not silently convert to approval; revision requires publishing a new version.

## UX promises
A professional can create a new request from a project in under two minutes in usability tests. A client should understand and decide on the proposal in under one minute, if the scope is simple. These are **targets to test**, not achieved metrics.

## Non-goals
Quotes for original projects, e-invoices, contracts drafted by AI, work trackers, job scheduling, client portals requiring accounts, automatic WhatsApp sending, contractor payment collection.

## Business model hypothesis
Test a free trial and either 9 USD/month or transaction/package pricing. Do not implement paid plans until evidence from pilot interviews and purchase intent. Google Play Billing compliance review required.

## Success measures
- % of participants completing a change request without help.
- % of invited clients able to review and respond.
- Median time to publish and decide.
- Requests accepted/declined; revision cycle.
- User-reported avoided unpaid work (self-report; not proof of net benefit).
- Actual paid conversions and retention over at least one full project cycle.
