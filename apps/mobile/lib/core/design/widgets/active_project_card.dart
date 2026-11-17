import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/theme/app_colors.dart';
import '../../../features/projects/domain/value_objects/project_status.dart';

class ActiveProjectCard extends StatelessWidget {
  const ActiveProjectCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.progress,
    super.key,
    this.imageUrl,
    this.fallbackIcon = Icons.folder_open,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final ProjectStatus status;
  final double progress; // 0.0 to 1.0
  final String? imageUrl;
  final IconData fallbackIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : AppColors.white;
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFE2E6DD);
    final titleColor = isDark ? AppColors.darkText : AppColors.graphite900;
    final mutedColor = isDark ? AppColors.darkMuted : AppColors.neutralMuted;
    final percentageText = '${(progress * 100).toInt()}%';
    final isPaused = status == ProjectStatus.paused;
    final statusBackground = isPaused
        ? AppColors.badgePausedBg
        : AppColors.badgeGreenBg;
    final statusForeground = isPaused
        ? AppColors.badgePausedText
        : AppColors.badgeGreenText;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Top row: Thumbnail + Details + Status + Chevron
                Row(
                  children: [
                    // Image / Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 56,
                        height: 56,
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.limeSoft,
                        child: imageUrl != null
                            ? Image.network(
                                imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Icon(
                                  fallbackIcon,
                                  color: mutedColor,
                                  size: 22,
                                ),
                              )
                            : Icon(fallbackIcon, color: mutedColor, size: 22),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Title & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: mutedColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isPaused
                                  ? AppColors.darkMuted
                                  : AppColors.limePrimary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            status.label,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: statusForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Chevron
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.darkMuted,
                    ),
                  ],
                ),
                const SizedBox(height: 9),

                // Bottom row: Progress bar + Percentage
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 7,
                          backgroundColor: isDark
                              ? AppColors.darkBorder
                              : const Color(0xFFE5E9E0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.limePrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      percentageText,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
