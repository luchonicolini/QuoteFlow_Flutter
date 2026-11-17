import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/theme/app_colors.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      backgroundColor: AppColors.graphiteBg,
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF161914),
          border: Border(top: BorderSide(color: Color(0xFF262C23), width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: _NavItem(
                    index: 0,
                    currentIndex: currentIndex,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: 'Inicio',
                    onTap: () => navigationShell.goBranch(0),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    index: 1,
                    currentIndex: currentIndex,
                    icon: Icons.folder_outlined,
                    activeIcon: Icons.folder_rounded,
                    label: 'Proyectos',
                    onTap: () => navigationShell.goBranch(1),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    index: 2,
                    currentIndex: currentIndex,
                    icon: Icons.add_box_outlined,
                    activeIcon: Icons.add_box_rounded,
                    label: 'Cambios',
                    onTap: () => navigationShell.goBranch(2),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    index: 3,
                    currentIndex: currentIndex,
                    icon: Icons.person_outline,
                    activeIcon: Icons.person_rounded,
                    label: 'Perfil',
                    onTap: () => navigationShell.goBranch(3),
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

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
  });

  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    final color = isSelected ? AppColors.limePrimary : const Color(0xFF7A8275);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? activeIcon : icon, size: 24, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            // Active underline indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isSelected ? 16 : 0,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.limePrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
