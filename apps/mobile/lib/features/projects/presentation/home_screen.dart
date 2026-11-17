import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../core/design/widgets/active_project_card.dart';
import '../../../core/design/widgets/scope_guard_logo.dart';
import '../data/repositories/demo_project_repository.dart';

/// Home is a compact operational overview: pending work first, then projects.
/// Demo counts are labeled as examples until backed by persisted data.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;
    final mutedColor =
        theme.textTheme.bodyMedium?.color ?? AppColors.neutralMuted;
    final projects = DemoProjectRepository.projects.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Row(
                  children: [
                    const ScopeGuardLogo(size: 28),
                    const SizedBox(width: 9),
                    Text(
                      'ScopeGuard',
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Notificaciones',
                      onPressed: () {},
                      icon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.notifications_none_rounded,
                            color: textColor,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: AppColors.limePrimary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      radius: 19,
                      backgroundColor: isDark
                          ? AppColors.darkSurface
                          : AppColors.limeSoft,
                      child: Icon(Icons.person_outline, color: mutedColor),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    text: 'Buen día, ',
                    style: GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.16,
                      letterSpacing: -0.8,
                      color: textColor,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Luciano',
                        style: TextStyle(color: AppColors.limePrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tus proyectos y cambios, en un solo lugar.',
                  style: theme.textTheme.bodyLarge?.copyWith(color: mutedColor),
                ),
                const SizedBox(height: 22),
                _PendingSummary(
                  isDark: isDark,
                  onTap: () => context.go('/change-requests'),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Proyectos activos',
                        style: GoogleFonts.manrope(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => context.go('/projects'),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 48),
                        foregroundColor: mutedColor,
                      ),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text('Ver todos'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (projects.isEmpty)
                  _EmptyProjects(isDark: isDark)
                else
                  for (final project in projects)
                    ActiveProjectCard(
                      title: project.title,
                      subtitle: project.serviceType,
                      status: project.status,
                      progress: project.progress,
                      fallbackIcon: Icons.folder_open_rounded,
                      onTap: () => context.push('/projects/${project.id}'),
                    ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: () => context.push('/change-requests/new'),
                    icon: const Icon(Icons.add_rounded, size: 25),
                    label: Text(
                      'Nueva solicitud de cambio',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.limePrimary,
                      foregroundColor: AppColors.graphite900,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PendingSummary extends StatelessWidget {
  const _PendingSummary({required this.isDark, required this.onTap});

  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final background = isDark ? AppColors.darkSurface : AppColors.white;
    final border = isDark ? AppColors.darkBorder : const Color(0xFFE2E6DD);
    final foreground = isDark ? AppColors.darkText : AppColors.graphite900;
    final secondary = isDark ? AppColors.darkMuted : AppColors.neutralMuted;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(minHeight: 112),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.limePrimary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.layers_outlined,
                  color: AppColors.graphite900,
                  size: 25,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Solicitudes pendientes',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: secondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '3',
                      style: GoogleFonts.manrope(
                        fontSize: 30,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        color: foreground,
                      ),
                    ),
                    Text(
                      'Datos de demostración',
                      style: GoogleFonts.inter(fontSize: 12, color: secondary),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: secondary, size: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyProjects extends StatelessWidget {
  const _EmptyProjects({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: isDark ? AppColors.darkSurface : AppColors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: isDark ? AppColors.darkBorder : const Color(0xFFE2E6DD),
      ),
    ),
    child: Text(
      'Todavía no hay proyectos. Creá uno para organizar el alcance acordado.',
      style: Theme.of(context).textTheme.bodyMedium,
    ),
  );
}
