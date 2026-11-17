import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../core/design/widgets/active_project_card.dart';
import '../../../core/design/widgets/scope_guard_logo.dart';
import '../application/project_providers.dart';
import '../domain/entities/project.dart';
import '../domain/use_cases/filter_projects.dart';
import '../domain/value_objects/project_status.dart';
import 'widgets/new_project_sheet.dart';
import 'widgets/project_summary_sheet.dart';

class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  String _selectedFilter = 'Activos';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Project> _filterProjects(List<Project> projects) =>
      const FilterProjects()(
        projects,
        query: _searchQuery,
        status: switch (_selectedFilter) {
          'Pausados' => ProjectStatus.paused,
          'Finalizados' => ProjectStatus.completed,
          _ => null,
        },
      );

  Future<void> _showNewProjectModal() => NewProjectSheet.show(context);

  Future<void> _showProjectDetails(Project project) =>
      ProjectSummarySheet.show(context, project);

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectsProvider);
    final allProjects = projectsAsync.asData?.value ?? const <Project>[];
    final filtered = _filterProjects(allProjects);

    return Scaffold(
      backgroundColor: AppColors.graphiteBg,
      body: Stack(
        children: [
          // Ambient lime glow in background
          Positioned(
            top: 50,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
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
                    // Header Bar: Logo + Notifications + Avatar
                    Row(
                      children: [
                        const ScopeGuardLogo(size: 26),
                        const SizedBox(width: 8),
                        Text(
                          'ScopeGuard',
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const Spacer(),

                        // Notification Bell with Lime Dot Indicator
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.darkText,
                                size: 24,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
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
                        const SizedBox(width: 14),

                        // User Avatar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF384033),
                                width: 1.5,
                              ),
                            ),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.person,
                                color: AppColors.darkMuted,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Proyectos',
                      style: GoogleFonts.manrope(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Gestioná y hacé seguimiento de todos\ntus proyectos en un solo lugar.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.darkMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 44,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.limePrimary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Search input
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFF171B1B),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppColors.darkBorder),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (val) =>
                                  setState(() => _searchQuery = val),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Buscar proyecto...',
                                hintStyle: const TextStyle(
                                  color: AppColors.darkMuted,
                                  fontSize: 13,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: AppColors.darkMuted,
                                  size: 23,
                                ),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: AppColors.darkMuted,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() => _searchQuery = '');
                                        },
                                      )
                                    : null,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFF171B1B),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.darkBorder),
                          ),
                          child: IconButton(
                            tooltip: 'Filtros',
                            onPressed: () => setState(() {
                              _selectedFilter = _selectedFilter == 'Activos'
                                  ? 'Pausados'
                                  : 'Activos';
                            }),
                            icon: const Icon(
                              Icons.tune_rounded,
                              color: AppColors.darkText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Filter chips row
                    if (projectsAsync.hasValue) ...[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _filterChip(
                              'Activos',
                              allProjects
                                  .where(
                                    (p) =>
                                        p.status != ProjectStatus.paused &&
                                        p.status != ProjectStatus.completed,
                                  )
                                  .length,
                            ),
                            const SizedBox(width: 8),
                            _filterChip(
                              'Pausados',
                              allProjects
                                  .where(
                                    (p) => p.status == ProjectStatus.paused,
                                  )
                                  .length,
                            ),
                            const SizedBox(width: 8),
                            _filterChip(
                              'Finalizados',
                              allProjects
                                  .where(
                                    (p) => p.status == ProjectStatus.completed,
                                  )
                                  .length,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],

                    // Projects list
                    if (projectsAsync.isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.limePrimary,
                          ),
                        ),
                      )
                    else if (projectsAsync.hasError)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.cloud_off_outlined,
                                size: 40,
                                color: AppColors.darkMuted,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No se pudieron cargar los proyectos',
                                style: GoogleFonts.manrope(
                                  color: AppColors.darkText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    ref.invalidate(projectsProvider),
                                child: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (filtered.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.search_off_rounded,
                                size: 40,
                                color: AppColors.darkMuted,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No se encontraron proyectos',
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Probá con otro término de búsqueda o filtro.',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppColors.darkMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...filtered.map(
                        (p) => ActiveProjectCard(
                          title: p.title,
                          subtitle: '${p.client} • ${p.serviceType}',
                          status: p.status,
                          progress: p.progress,
                          imageUrl: p.imageUrl.isEmpty ? null : p.imageUrl,
                          onTap: () => _showProjectDetails(p),
                        ),
                      ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _showNewProjectModal,
                        icon: const Icon(Icons.add, size: 28),
                        label: Text(
                          'Nuevo proyecto',
                          style: GoogleFonts.manrope(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.limePrimary,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, int count) {
    final isSelected = _selectedFilter == label;
    final bg = isSelected ? AppColors.limePrimary : AppColors.darkSurface;
    final fg = isSelected ? AppColors.graphite900 : AppColors.darkMuted;
    final border = isSelected ? null : Border.all(color: AppColors.darkBorder);

    return InkWell(
      onTap: () => setState(() => _selectedFilter = label),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: border,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: fg,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.graphite900.withValues(alpha: 0.2)
                    : const Color(0xFF2E352A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: fg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
