import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/theme/app_colors.dart';

class KpiCard extends StatelessWidget {
  const KpiCard({
    required this.value,
    required this.label,
    required this.icon,
    super.key,
    this.isHighlighted = false,
    this.onTap,
  });

  final String value;
  final String label;
  final IconData icon;
  final bool isHighlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bgColor = isHighlighted
        ? AppColors.limePrimary
        : AppColors.darkSurface;
    final fgColor = isHighlighted ? AppColors.graphite900 : AppColors.darkText;
    final mutedFgColor = isHighlighted
        ? AppColors.graphite900.withValues(alpha: 0.85)
        : AppColors.darkMuted;
    final iconColor = isHighlighted ? AppColors.graphite900 : Colors.white70;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 124,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: isHighlighted
                ? null
                : Border.all(color: AppColors.darkBorder, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top icon
              Icon(icon, size: 20, color: iconColor),

              // Value
              Text(
                value,
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: fgColor,
                  height: 1.1,
                ),
              ),

              // Bottom label + chevron
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: isHighlighted
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: mutedFgColor,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 16, color: mutedFgColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
