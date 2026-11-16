# ScopeGuard Design System v1 — Lime & Graphite

Status: selected visual direction for prototyping. Verify accessibility with real device screenshots before implementation freeze.

## Identity
**Modern professional utility**, clear hierarchy, calm surfaces, no SaaS-template appearance. The lime is an **accent**, not a permanent background. Prefer graphite in dark mode, warm canvas in light mode.

## Base tokens
| Token | Value | Use |
|---|---|---|
| lime.primary | `#C5F277` | Primary CTA on graphite, highlights |
| graphite.900 | `#20231F` | Dark base, dark text on lime |
| canvas.50 | `#F7F8F3` | Light theme background |
| lime.soft | `#E9F3DB` | Light accent surfaces |
| neutral.muted | `#62685B` | Muted text on light |
| dark.surface | `#30352D` | Cards in dark mode |
| dark.border | `#454B3D` | Outlines/dividers |
| dark.text | `#F7F8F3` | Primary dark-mode text |
| dark.muted | `#BFC7B7` | Secondary dark-mode text |
| error | `#B64C43` | Error status on light; contrast-test dark variant |
| pending | `#8E6C22` | Pending status on light; contrast-test dark variant |

**Contrast rule:** graphite text and icons on lime. Never use white text on the lime primary. Verify WCAG 2.2 AA for body text (>=4.5:1), non-text UI (>=3:1), and all text/state variants.

## Semantic colors
- Light: background `#F7F8F3`, main text `#20231F`, surface `#FFFFFF`, soft accent `#E9F3DB`, disabled/secondary `#62685B`.
- Dark: background `#20231F`, main text `#F7F8F3`, surface `#30352D`, border `#454B3D`, subdued text `#BFC7B7`.
- Status labels include icons + text: `Borrador`, `Enviada`, `Aprobada`, `Rechazada`, `Vencida`, `Revocada`. Never use color alone.

## Typography
- Preferred titles: **Manrope**, fallback system sans.
- Preferred UI/body: **Inter**, fallback system sans.
- Obtain fonts under appropriate licenses when implementing; do not commit unlicensed font files.
- Type scale (Flutter logical px): display 30/36 semi-bold, H1 24/30 bold, H2 20/26 semi-bold, body 16/24 regular, support 14/20, caption 12/16.
- Monetary data: tabular figures where available.

## Components
- App bar 56dp; main layout horizontal padding 20dp mobile, responsive max content 760px on larger screens.
- Spacing scale 4 / 8 / 12 / 16 / 24 / 32 / 48.
- Radius 12 for controls, 16 for cards, 24 for large containers. No generic gray drop shadows.
- Primary button height >=48dp, lime background with graphite foreground; secondary outlined/tonal; destructive distinct and confirmed.
- Form input minimum height 48dp, label always visible, inline validation/error.
- Navigation: up to 4 areas Home, Projects, Requests, Profile. New change action visible in context, avoid competing FAB and CTA.
- Cards: flat charcoal surfaces in dark theme; white in light theme with subtle divider.
- Badges: small neutral shapes with text; no cluttered colored tags.
- Loading: skeleton or progressive states; no fake success states.

## Screen principles
**Home**: actionable recent requests and project list, not a decorative KPI dashboard. Never aggregate money from different currencies.
**Project**: baseline scope and approved changes prominently separated.
**Request editor**: form > preview > publish; show price and schedule impact unmistakably.
**Approval web**: essential text above the fold; plain-English/Spanish action labels; no sign-in or tracking scripts; explicit decision confirmation.

## Themes
Support light, dark and system preference; high-contrast device settings where applicable. Dark is the preferred marketing showcase but never force dark on users who prefer light.

## UX and animation
- Short 150–250ms purposeful transitions, respect reduced motion.
- Make destructive operations reversible where sensible; never animate a false completed approval.
- Screen reader labels for every action, 48dp tap targets, appropriate focus and error announcements.
- Avoid gradients as decoration, exaggerated glassmorphism, floating blobs and repetitive boxed icons.

## Design quality gate
Prototype actual phone widths (360, 393, 412dp), large text and dark mode; web approval at 320, 375, 768 and 1280 CSS px. Audit all states including loading, error, empty, expired, revoked and rejected.
