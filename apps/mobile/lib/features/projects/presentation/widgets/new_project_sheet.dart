import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/design/widgets/app_button.dart';

/// Prototype form. Persistence is intentionally not implied until a repository
/// operation is implemented.
class NewProjectSheet extends StatelessWidget {
  const NewProjectSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.darkSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      side: BorderSide(color: AppColors.darkBorder),
    ),
    builder: (_) => const NewProjectSheet(),
  );

  @override
  Widget build(BuildContext context) {
    final titleCtrl = TextEditingController();
    final clientCtrl = TextEditingController();
    final budgetCtrl = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nuevo proyecto',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.darkMuted),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration(
              'Nombre del proyecto',
              'Ej. Rediseño Web',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: clientCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Cliente', 'Ej. Estudio Norte'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: budgetCtrl,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Presupuesto base (USD)', 'Ej. 2500'),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Guardar proyecto',
            icon: Icons.check,
            borderRadius: 27,
            height: 52,
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'El guardado de proyectos todavía no está conectado.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    String hint,
  ) => InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: AppColors.darkMuted),
    hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFF5A6354)),
    filled: true,
    fillColor: const Color(0xFF1B1E19),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.limePrimary, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}
