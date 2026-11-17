import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/design/widgets/app_button.dart';
import '../../domain/entities/project.dart';

class ProjectSummarySheet extends StatelessWidget {
  const ProjectSummarySheet({required this.project, super.key});

  final Project project;

  static Future<void> show(BuildContext context, Project project) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          side: BorderSide(color: AppColors.darkBorder),
        ),
        builder: (_) => ProjectSummarySheet(project: project),
      );

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: 0.75,
    minChildSize: 0.5,
    maxChildSize: 0.95,
    expand: false,
    builder: (context, scrollController) => ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.darkBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 52,
                height: 52,
                color: const Color(0xFF2C3229),
                child: project.imageUrl.isEmpty
                    ? const Icon(Icons.business, color: AppColors.darkMuted)
                    : Image.network(
                        project.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.business,
                          color: AppColors.darkMuted,
                        ),
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
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  Text(
                    '${project.client} • ${project.serviceType}',
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
        const SizedBox(height: 20),
        _FinancialBreakdown(project: project),
        const SizedBox(height: 20),
        _ItemList(
          title: 'Entregables incluidos en alcance:',
          items: project.deliverables,
          icon: Icons.check_circle_rounded,
          iconColor: AppColors.limePrimary,
        ),
        const SizedBox(height: 16),
        _ItemList(
          title: 'Exclusiones explícitas:',
          items: project.exclusions,
          icon: Icons.remove_circle_outline,
          iconColor: AppColors.darkMuted,
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Nueva solicitud sobre este proyecto',
          icon: Icons.add,
          borderRadius: 27,
          height: 52,
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'El envío de solicitudes todavía no está conectado.',
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

class _FinancialBreakdown extends StatelessWidget {
  const _FinancialBreakdown({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1B1E19),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.darkBorder),
    ),
    child: Column(
      children: [
        _AmountRow(
          label: 'Presupuesto original:',
          amount: project.baseBudget.format(),
        ),
        const SizedBox(height: 8),
        _AmountRow(
          label: 'Cambios acordados (${project.approvedChangesCount}):',
          amount: '+${project.extraAmount.format()}',
          amountColor: AppColors.limePrimary,
        ),
        const Divider(color: AppColors.darkBorder, height: 20),
        _AmountRow(
          label: 'Presupuesto actualizado:',
          amount: (project.baseBudget + project.extraAmount).format(),
          amountColor: AppColors.limePrimary,
          bold: true,
        ),
      ],
    ),
  );
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.amount,
    this.amountColor = AppColors.darkText,
    this.bold = false,
  });

  final String label;
  final String amount;
  final Color amountColor;
  final bool bold;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: bold ? AppColors.darkText : AppColors.darkMuted,
            fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            fontSize: bold ? 14 : 13,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Text(
        amount,
        style: GoogleFonts.manrope(
          color: amountColor,
          fontWeight: FontWeight.bold,
          fontSize: bold ? 18 : 15,
        ),
      ),
    ],
  );
}

class _ItemList extends StatelessWidget {
  const _ItemList({
    required this.title,
    required this.items,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final List<String> items;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
      const SizedBox(height: 8),
      ...items.map(
        (item) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: iconColor == AppColors.darkMuted
                        ? AppColors.darkMuted
                        : AppColors.darkText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
