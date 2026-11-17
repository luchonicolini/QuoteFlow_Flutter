import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class ScopeGuardLogo extends StatelessWidget {
  const ScopeGuardLogo({
    super.key,
    this.size = 28.0,
    this.color = AppColors.limePrimary,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 0.9),
      painter: _ScopeGuardLogoPainter(color: color),
    );
  }
}

class _ScopeGuardLogoPainter extends CustomPainter {
  const _ScopeGuardLogoPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.16
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Top chevron / loop
    final topPath = Path()
      ..moveTo(w * 0.72, h * 0.18)
      ..lineTo(w * 0.35, h * 0.18)
      ..lineTo(w * 0.15, h * 0.42)
      ..lineTo(w * 0.50, h * 0.42)
      ..lineTo(w * 0.85, h * 0.42);

    // Bottom chevron / loop
    final bottomPath = Path()
      ..moveTo(w * 0.15, h * 0.58)
      ..lineTo(w * 0.50, h * 0.58)
      ..lineTo(w * 0.85, h * 0.58)
      ..lineTo(w * 0.65, h * 0.82)
      ..lineTo(w * 0.28, h * 0.82);

    canvas.drawPath(topPath, paint);
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant _ScopeGuardLogoPainter oldDelegate) =>
      oldDelegate.color != color;
}
