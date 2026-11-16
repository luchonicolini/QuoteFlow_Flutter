---
name: flutter-visual-qa
description: Use after building a screen, changing design tokens or before accepting a UI pull request.
---

# Visual and Accessibility QA

Review screenshots from an actual Android emulator/device when available; do not claim visual verification without images.

## Checklist
- Test 360, 393 and 412dp, dark/light/system and large text.
- Compare screen to `docs/DESIGN_SYSTEM.md`: spacing, hierarchy, typography, foreground/background, radius and CTA placement.
- Test long client/project names, large monetary amounts, no data, loading, errors and offline.
- Verify text contrast >=4.5:1 for normal text, non-text contrast >=3:1 and touch targets >=48dp.
- Test TalkBack labels, focus order, text field errors, status descriptions and reduced motion.
- Use Flutter widget/golden tests for stable states; review golden updates instead of blindly accepting diffs.
- Record issues with screenshot path, steps, expected and actual; re-test fixes.

Never claim pixel-perfect parity from code inspection alone.
