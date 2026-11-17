import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/scope_guard_logo.dart';
import '../application/project_providers.dart';

class ProjectDetailScreen extends ConsumerStatefulWidget {
  const ProjectDetailScreen({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<ProjectDetailScreen> createState() =>
      _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends ConsumerState<ProjectDetailScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectsProvider);
    final project = projectState.asData?.value
        .where((item) => item.id == widget.projectId)
        .firstOrNull;
    if (projectState.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.graphiteBg,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.limePrimary),
        ),
      );
    }
    if (projectState.hasError || project == null) {
      return Scaffold(
        backgroundColor: AppColors.graphiteBg,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No se encontró el proyecto.'),
              TextButton(
                onPressed: () => context.go('/projects'),
                child: const Text('Volver a proyectos'),
              ),
            ],
          ),
        ),
      );
    }
    final currentBudget = project.baseBudget + project.extraAmount;

    return Scaffold(
      backgroundColor: AppColors.graphiteBg,
      body: Stack(
        children: [
          // Ambient lime glow
          Positioned(
            top: 40,
            right: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.limePrimary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  children: [
                    // Top App Header: Back + Brand + More options
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Volver a proyectos',
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.darkText,
                            size: 24,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => context.pop(),
                        ),
                        const Spacer(),
                        const ScopeGuardLogo(size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'ScopeGuard',
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          tooltip: 'Más opciones',
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: AppColors.darkText,
                            size: 24,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Opciones del proyecto'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Project Identity Header
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 72,
                            height: 72,
                            color: const Color(0xFF2C3229),
                            child: const Icon(
                              Icons.apartment_rounded,
                              size: 34,
                              color: AppColors.darkMuted,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                project.serviceType,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: AppColors.darkMuted,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Status pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.badgeGreenBg,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.limePrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'En revisión',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.badgeGreenText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Progress bar
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: project.progress,
                              minHeight: 6,
                              backgroundColor: Color(0xFF2C3328),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.limePrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${(project.progress * 100).round()}%',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Project Tabs
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _tabPill('Resumen', 0),
                          const SizedBox(width: 6),
                          _tabPill('Cambios  2', 1),
                          const SizedBox(width: 6),
                          _tabPill('Archivos', 2),
                          const SizedBox(width: 6),
                          _tabPill('Actividad', 3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Budget & Variation Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        border: Border.all(color: AppColors.darkBorder),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Presupuesto actual',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.darkMuted,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currentBudget.format(),
                                  style: GoogleFonts.manrope(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 42,
                            color: AppColors.darkBorder,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Variación',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.darkMuted,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '↗ +12,6 %',
                                  style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.limePrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Scope Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.darkBorder),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.task_alt_rounded,
                            color: AppColors.limePrimary,
                            size: 26,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alcance del proyecto',
                                  style: GoogleFonts.manrope(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  project.scopeSummary,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.darkMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.darkMuted,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Milestone Progress Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Avance del proyecto',
                          style: GoogleFonts.manrope(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        Text(
                          '${(project.progress * 100).round()}% completado',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.darkMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Timeline steps
                    for (
                      var index = 0;
                      index < project.milestones.length;
                      index++
                    )
                      _timelineStep(
                        project.milestones[index].title,
                        project.milestones[index].dateLabel,
                        project.milestones[index].isComplete,
                        isLast: index == project.milestones.length - 1,
                      ),
                    const SizedBox(height: 22),

                    // Recent Activity Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Actividad reciente',
                          style: GoogleFonts.manrope(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Ver historial',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.limePrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Latest activity or a clear empty state.
                    if (project.latestActivity case final activity?)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.darkSurface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.darkBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B1E19),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.description_outlined,
                                size: 20,
                                color: AppColors.limePrimary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkText,
                                    ),
                                  ),
                                  Text(
                                    activity.description,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.darkMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              activity.dateLabel,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppColors.darkMuted,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Todavía no hay actividad para este proyecto.',
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Main Action CTA Button
                    AppButton(
                      text: 'Nueva solicitud de cambio',
                      icon: Icons.add,
                      borderRadius: 27,
                      height: 52,
                      onPressed: () => context.push('/change-requests/new'),
                    ),
                    const SizedBox(height: 12),

                    Center(
                      child: Text(
                        'Presupuesto, avance y actividad son datos de ejemplo.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.darkMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabPill(String label, int index) {
    final isSelected = _selectedTabIndex == index;

    return InkWell(
      onTap: () {
        setState(() => _selectedTabIndex = index);
        if (index == 1) {
          context.push('/change-requests');
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.limePrimary : AppColors.darkSurface,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: AppColors.darkBorder),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColors.graphite900 : AppColors.darkMuted,
          ),
        ),
      ),
    );
  }

  Widget _timelineStep(
    String title,
    String date,
    bool done, {
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? AppColors.limePrimary : Colors.transparent,
              border: done
                  ? null
                  : Border.all(color: AppColors.darkBorder, width: 2),
            ),
            child: done
                ? const Icon(
                    Icons.check,
                    size: 15,
                    color: AppColors.graphite900,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: done ? FontWeight.w600 : FontWeight.w400,
                color: done ? AppColors.darkText : AppColors.darkMuted,
              ),
            ),
          ),
          Text(
            date,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.darkMuted),
          ),
        ],
      ),
    );
  }
}
