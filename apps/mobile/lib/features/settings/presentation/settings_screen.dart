import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../core/design/widgets/scope_guard_logo.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _showSignOutDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        title: Text(
          'Cerrar sesión',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
          ),
        ),
        content: Text(
          '¿Estás seguro de que querés cerrar la sesión de tu cuenta ScopeGuard?',
          style: GoogleFonts.inter(color: AppColors.darkMuted, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancelar',
              style: GoogleFonts.inter(color: AppColors.darkMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No hay una sesión activa para cerrar.'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A2321),
              foregroundColor: const Color(0xFFE57373),
              elevation: 0,
            ),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.graphiteBg,
      body: Stack(
        children: [
          // Ambient lime glow on the top-right matching the Home screen
          Positioned(
            top: 40,
            right: -90,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.limePrimary.withValues(alpha: 0.16),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 140,
            left: -110,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.limePrimary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main scrollable content
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
                    // Top App Header: Logo + Notification + More options
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
                        const SizedBox(width: 8),

                        // More options vertical dots
                        IconButton(
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: AppColors.darkText,
                            size: 24,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // User Profile Header: Avatar + Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar with camera badge
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                width: 74,
                                height: 74,
                                color: const Color(0xFF2C3229),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const Icon(
                                    Icons.person,
                                    size: 38,
                                    color: AppColors.darkMuted,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.darkSurface,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.darkBorder,
                                    width: 1.5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),

                        // User details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Luciano',
                                style: GoogleFonts.manrope(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkText,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Plan Pro Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF23301D),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF35452C),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  '👑 Plan Pro',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.limePrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),

                              Text(
                                'luciano@nicolini.dev',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppColors.darkMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    // Quick Stats Row (Continuous container with dividers)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.darkBorder,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // 1: Proyectos
                          Expanded(
                            child: _StatItem(
                              icon: Icons.layers_outlined,
                              value: '7',
                              label: 'Proyectos',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            color: AppColors.darkBorder,
                          ),
                          // 2: Cambios
                          Expanded(
                            child: _StatItem(
                              icon: Icons.sync_alt_rounded,
                              value: '14',
                              label: 'Cambios',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            color: AppColors.darkBorder,
                          ),
                          // 3: Rentabilidad
                          Expanded(
                            child: _StatItem(
                              icon: Icons.bar_chart_rounded,
                              value: '+18%',
                              label: 'Rentabilidad',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),

                    // Section: "Configuración"
                    Text(
                      'Configuración',
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Grouped Settings List
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.darkBorder,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          SettingsTile(
                            icon: Icons.person_outline,
                            title: 'Información personal',
                            subtitle:
                                'Editá tu perfil, email y datos de contacto',
                            onTap: () {},
                          ),
                          _buildDivider(),
                          SettingsTile(
                            icon: Icons.notifications_none_rounded,
                            title: 'Notificaciones',
                            subtitle: 'Gestioná alertas y recordatorios',
                            trailing: Transform.scale(
                              scale: 0.85,
                              child: Switch(
                                value: _notificationsEnabled,
                                activeThumbColor: Colors.white,
                                activeTrackColor: AppColors.limePrimary,
                                inactiveTrackColor: const Color(0xFF2F352B),
                                inactiveThumbColor: AppColors.darkMuted,
                                onChanged: (val) {
                                  setState(() => _notificationsEnabled = val);
                                },
                              ),
                            ),
                          ),
                          _buildDivider(),
                          SettingsTile(
                            icon: Icons.dark_mode_outlined,
                            title: 'Apariencia',
                            subtitle: 'Tema, color de acento y estilo',
                            onTap: () {},
                          ),
                          _buildDivider(),
                          SettingsTile(
                            icon: Icons.verified_user_outlined,
                            title: 'Seguridad',
                            subtitle: 'Contraseña, sesión y verificación',
                            onTap: () {},
                          ),
                          _buildDivider(),
                          SettingsTile(
                            icon: Icons.help_outline_rounded,
                            title: 'Ayuda y soporte',
                            subtitle:
                                'Preguntas frecuentes, contacto y feedback',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Destructive Button: "Cerrar sesión"
                    InkWell(
                      onTap: _showSignOutDialog,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF261B1B).withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF4D2825),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout_rounded,
                              size: 18,
                              color: Color(0xFFE57373),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Cerrar sesión',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE57373),
                              ),
                            ),
                          ],
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

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFF2A2F26),
      indent: 52,
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: AppColors.limePrimary),
            const SizedBox(width: 6),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.darkMuted,
          ),
        ),
      ],
    );
  }
}
