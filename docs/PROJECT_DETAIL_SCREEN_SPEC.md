# Project detail — visual reference

The project detail screen follows the owner-provided mockup at [`PROJECT_DETAIL_REFERENCE.png`](PROJECT_DETAIL_REFERENCE.png).

## Hierarchy and actions

Brand/back navigation → project identity, status and progress → tabs for Resumen, Cambios, Archivos and Actividad → current budget and variation → baseline scope → milestone progress → recent activity → primary action to prepare a change request.

The Cambios tab navigates to the existing demo section. Other tabs and secondary controls explain that they are not implemented. The primary CTA navigates to the placeholder change section; it does not create or publish a request.

## Demo data

Project name, status, progress, budget, budget variation, baseline scope, dates, change count and activity text are illustrative fixtures. They are not saved and no calculations are derived from project data. The screen states that amounts and activity are examples.

## Responsive and accessibility

Content scrolls while the bottom navigation stays fixed. The project name and description can truncate/wrap safely. Budget fields remain labelled with USD. Milestone completion uses both a check icon and text/date context rather than color alone. Verify at 360/393/412 dp, larger text, light/dark and long content.

## Visual QA

The mockup uses a photographic building background; the implementation uses a neutral Material icon placeholder because no licensed project photo asset was provided. Emulator screenshots and visual comparison remain pending.
