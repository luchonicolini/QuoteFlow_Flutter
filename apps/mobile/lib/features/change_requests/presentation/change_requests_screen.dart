import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../core/design/widgets/scope_guard_logo.dart';

enum _ChangeStatus { pending, approved, rejected }

class _ChangeRequest {
  const _ChangeRequest({
    required this.project,
    required this.description,
    required this.code,
    required this.date,
    required this.amount,
    required this.status,
  });

  final String project;
  final String description;
  final String code;
  final String date;
  final String amount;
  final _ChangeStatus status;
}

class ChangeRequestsScreen extends StatefulWidget {
  const ChangeRequestsScreen({super.key});

  @override
  State<ChangeRequestsScreen> createState() => _ChangeRequestsScreenState();
}

class _ChangeRequestsScreenState extends State<ChangeRequestsScreen> {
  String _filter = 'Todos';

  static const _requests = [
    _ChangeRequest(
      project: 'Estudio Norte',
      description: 'Agregar catálogo de productos con filtros y detalle.',
      code: 'CAM-0042',
      date: '14 ene 2026',
      amount: '+ USD 480',
      status: _ChangeStatus.pending,
    ),
    _ChangeRequest(
      project: 'Hotel Intermonti',
      description: 'Integración de sistema de reservas.',
      code: 'CAM-0041',
      date: '11 ene 2026',
      amount: '+ USD 1.200',
      status: _ChangeStatus.approved,
    ),
    _ChangeRequest(
      project: 'Crismalu',
      description: 'Cambio de estructura y nuevas secciones.',
      code: 'CAM-0039',
      date: '8 ene 2026',
      amount: '+ USD 320',
      status: _ChangeStatus.rejected,
    ),
  ];

  List<_ChangeRequest> get _visibleRequests {
    if (_filter == 'Pendientes') {
      return _requests
          .where((request) => request.status == _ChangeStatus.pending)
          .toList();
    }
    if (_filter == 'Aprobados') {
      return _requests
          .where((request) => request.status == _ChangeStatus.approved)
          .toList();
    }
    if (_filter == 'Rechazados') {
      return _requests
          .where((request) => request.status == _ChangeStatus.rejected)
          .toList();
    }
    return _requests;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.graphiteBg,
    body: Stack(
      children: [
        Positioned(
          top: 120,
          right: -100,
          child: Container(
            width: 260,
            height: 260,
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
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                children: [
                  _buildBrandHeader(),
                  const SizedBox(height: 24),
                  Text(
                    'Cambios',
                    style: GoogleFonts.manrope(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Solicitudes de ajuste, mejoras o tareas adicionales.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.darkMuted,
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
                  _buildNewRequestButton(context),
                  const SizedBox(height: 20),
                  _buildFilters(),
                  const SizedBox(height: 18),
                  for (final request in _visibleRequests)
                    _ChangeRequestCard(request: request),
                  if (_visibleRequests.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          'No hay solicitudes en este estado.',
                          style: TextStyle(color: AppColors.darkMuted),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildBrandHeader() => Row(
    children: [
      const ScopeGuardLogo(size: 28),
      const SizedBox(width: 9),
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
      Stack(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.darkText,
              size: 24,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
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
      const SizedBox(width: 8),
      const CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.darkBorder,
        child: Icon(Icons.person, color: AppColors.darkMuted),
      ),
    ],
  );

  Widget _buildNewRequestButton(BuildContext context) => SizedBox(
    height: 54,
    child: ElevatedButton.icon(
      onPressed: () => context.push('/change-requests/new'),
      icon: const Icon(Icons.add, size: 25),
      label: Text(
        'Nueva solicitud de cambio',
        style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.limePrimary,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 0,
      ),
    ),
  );

  Widget _buildFilters() {
    const filters = ['Todos', 'Pendientes', 'Aprobados', 'Rechazados'];
    const counts = [3, 1, 1, 1];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < filters.length; index++) ...[
            if (index > 0) const SizedBox(width: 8),
            _FilterChip(
              label: filters[index],
              count: counts[index],
              selected: _filter == filters[index],
              onTap: () => setState(() => _filter = filters[index]),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(22),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.limePrimary : Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        border: selected ? null : Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: selected ? Colors.black : AppColors.darkMuted,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: selected
                  ? Colors.black.withValues(alpha: 0.16)
                  : const Color(0xFF353A34),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                color: selected ? Colors.black : AppColors.darkText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ChangeRequestCard extends StatelessWidget {
  const _ChangeRequestCard({required this.request});

  final _ChangeRequest request;

  Color get _accent => switch (request.status) {
    _ChangeStatus.pending => const Color(0xFFFFC83D),
    _ChangeStatus.approved => AppColors.limePrimary,
    _ChangeStatus.rejected => const Color(0xFFFF7474),
  };

  String get _statusLabel => switch (request.status) {
    _ChangeStatus.pending => 'Pendiente',
    _ChangeStatus.approved => 'Aprobada',
    _ChangeStatus.rejected => 'Rechazada',
  };

  IconData get _statusIcon => switch (request.status) {
    _ChangeStatus.pending => Icons.schedule_rounded,
    _ChangeStatus.approved => Icons.check_circle_rounded,
    _ChangeStatus.rejected => Icons.cancel_rounded,
  };

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: const Color(0xFF1B1F1E),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFF2A302F)),
    ),
    clipBehavior: Clip.antiAlias,
    child: IntrinsicHeight(
      child: Row(
        children: [
          Container(width: 4, color: _accent),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 68,
                          height: 68,
                          color: const Color(0xFF2C3229),
                          child: const Icon(
                            Icons.business_rounded,
                            color: AppColors.darkMuted,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.project,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              request.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.darkMuted,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right, color: AppColors.darkText),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        color: AppColors.darkMuted,
                        size: 17,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        request.code,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.darkMuted,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.darkMuted,
                        size: 17,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        request.date,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.darkMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      request.amount,
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.limePrimary,
                      ),
                    ),
                  ),
                  const Divider(color: Color(0xFF303633), height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.darkMuted,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          'Aprobación del cliente',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                      _ApprovalBadge(
                        status: request.status,
                        accent: _accent,
                        label: _statusLabel,
                        icon: _statusIcon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ApprovalBadge extends StatelessWidget {
  const _ApprovalBadge({
    required this.status,
    required this.accent,
    required this.label,
    required this.icon,
  });

  final _ChangeStatus status;
  final Color accent;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final pending = status == _ChangeStatus.pending;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!pending) Icon(icon, color: accent, size: 14),
          if (!pending) const SizedBox(width: 4),
          Text(
            pending ? 'En espera' : label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: pending ? AppColors.darkText : accent,
            ),
          ),
          if (pending) ...[
            const SizedBox(width: 6),
            const Icon(
              Icons.radio_button_unchecked,
              size: 14,
              color: AppColors.darkMuted,
            ),
          ],
        ],
      ),
    );
  }
}
