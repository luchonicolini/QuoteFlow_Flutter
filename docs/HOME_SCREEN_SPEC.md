# Home / Overview — visual reference

The Home screen follows the owner-provided dark mockup at [`HOME_REFERENCE_DARK.png`](HOME_REFERENCE_DARK.png). This is the visual target for the prototype; it has not been validated with device screenshots yet.

## User goal and hierarchy

- **Goal:** understand current requests and active project progress, then start a new change request.
- **Primary action:** `Nueva solicitud de cambio`.
- **Secondary actions:** open pending/approved metrics, view all projects, navigate among Inicio, Proyectos, Cambios and Perfil.
- **Content order:** ScopeGuard header and profile affordance → personalized greeting → three horizontally scrollable summary metrics → active projects with status and progress → primary CTA → bottom navigation.
- **States:** populated reference data is illustrative only; empty/loading/error states will replace it when repositories are introduced.

## Reference measurements

The reference is a dark Android phone mockup. Flutter implementation uses the project's Lime & Graphite tokens, graphite black canvas and dark cards. Layout should remain usable at 360, 393 and 412 logical pixels; metric cards scroll horizontally on narrow screens. Long project names truncate while retaining the status and progress value. The bottom navigation remains fixed while the page scrolls.

## Accessibility and data integrity

- Project state includes both text and a status icon/dot; progress includes a numeric percentage.
- The primary action and navigation targets use Material touch targets.
- Sample profile, project names, statuses, progress and summary figures are fake fixture data. The UI discloses that they are not saved.
- Do not present the sample `+12%` as a computed or authoritative financial value.
- No project card, notification control or change-request action claims to persist or publish data yet.

## Visual QA

Run on Android emulator at 360/393/412 dp, light and dark, with large text and long project names. Capture screenshots and compare against `HOME_REFERENCE_DARK.png`. No emulator comparison is claimed by this implementation pass.
