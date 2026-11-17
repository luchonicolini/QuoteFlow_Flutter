import 'package:flutter/material.dart';

/// Lime & Graphite design tokens for ScopeGuard.
/// Defined in docs/DESIGN_SYSTEM.md.
abstract final class AppColors {
  // Brand accents
  static const Color limePrimary = Color(0xFFC5F277);
  static const Color limeSoft = Color(0xFFE9F3DB);

  // Graphite / Neutral darks
  static const Color graphiteBg = Color(0xFF141713);
  static const Color graphite900 = Color(0xFF20231F);
  static const Color darkSurface = Color(0xFF222620);
  static const Color darkBorder = Color(0xFF32382E);

  // Canvas / Light surfaces
  static const Color canvas50 = Color(0xFFF7F8F3);
  static const Color white = Color(0xFFFFFFFF);

  // Text & muted states
  static const Color neutralMuted = Color(0xFF62685B);
  static const Color darkText = Color(0xFFF7F8F3);
  static const Color darkMuted = Color(0xFF9EA698);

  // Status badges & indicators
  static const Color badgeGreenBg = Color(0xFF23301D);
  static const Color badgeGreenText = Color(0xFFC5F277);
  static const Color badgePausedBg = Color(0xFF2A2E27);
  static const Color badgePausedText = Color(0xFFA5ACA0);

  // General Status colors
  static const Color error = Color(0xFFB64C43);
  static const Color pending = Color(0xFF8E6C22);
  static const Color approved = Color(0xFF2E7D32);
}
