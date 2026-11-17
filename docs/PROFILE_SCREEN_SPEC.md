# Profile — visual reference

The Profile screen follows the owner-provided dark reference at [`PROFILE_REFERENCE_DARK.png`](PROFILE_REFERENCE_DARK.png).

## Hierarchy

Brand header and notification/menu affordances → account identity and plan label → three account summary metrics → Configuration heading → personal information, notifications, appearance, security, help/support → sign-out action.

## Interaction and data limits

The current profile name, plan label and summary values are illustrative fixtures. No authenticated identity, paid entitlement, project/change counts, profitability calculation, notification preference, photo upload, account settings or sign-out behavior is implemented. Tapping those controls explains that the account is not connected; no success state is shown.

## Responsive/accessibility notes

The page scrolls independently of the fixed four-item bottom navigation. Summary metrics are distributed across available width with ellipsis at narrow widths. Settings rows keep 48dp interactive targets and pair lime icons with text labels. Longer subtitles can wrap to two lines.

## Visual QA

Target the attached image at 393dp in dark mode; also verify 360/412dp, light mode, larger text, long account names, switch semantics and fixed navigation. A widget test is not an emulator screenshot comparison; visual QA remains pending.
