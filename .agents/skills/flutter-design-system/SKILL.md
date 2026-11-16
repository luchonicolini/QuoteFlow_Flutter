---
name: flutter-design-system
description: Use when creating or editing Flutter UI, theme tokens, components, dark mode, typography or spacing.
---

# ScopeGuard Flutter Design System

Before UI work read `docs/DESIGN_SYSTEM.md`. Implement a single centralized token source for Lime #C5F277, Graphite #20231F, Canvas #F7F8F3, Soft Lime #E9F3DB and Muted #62685B. Use semantic ThemeData/ColorScheme tokens, never hardcoded widget colors. Use graphite foreground on lime. Support light/dark/system, large text, 48dp targets, semantic status icons+labels. Keep forms readable and approval decisions visually unambiguous.

## Workflow
1. Inspect reference screen and design tokens.
2. Plan widget hierarchy, loading/error/empty states and focus order.
3. Build reusable primitives (AppButton, AppField, AppCard, StatusChip) only where repeated.
4. Test at 360/393/412 logical px and dark/light, large text and TalkBack.
5. Capture screenshots and compare to approved reference; fix spacing and hierarchy before marking done.

Avoid generic SaaS dashboards, decorative gradients, glassmorphism and repeated CTA buttons.
