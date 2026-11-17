import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../core/design/widgets/app_button.dart';

class NewChangeRequestScreen extends StatefulWidget {
  const NewChangeRequestScreen({super.key});

  @override
  State<NewChangeRequestScreen> createState() => _NewChangeRequestScreenState();
}

class _NewChangeRequestScreenState extends State<NewChangeRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _daysController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: isDark ? AppColors.darkSurface : AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorder : const Color(0xFFD4D9CE),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorder : const Color(0xFFD4D9CE),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.limePrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva solicitud')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              Text(
                'Detalle del cambio fuera de alcance',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Documenta con precisión qué se agregará, el monto adicional y el impacto en cronograma.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.darkMuted : AppColors.neutralMuted,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: inputDecoration.copyWith(
                  labelText: 'Título de la solicitud',
                  hintText: 'Ej. Integración pasarela de pagos adicional',
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: inputDecoration.copyWith(
                  labelText: 'Descripción de entregables',
                  hintText: 'Describe el alcance adicional acordado...',
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration.copyWith(
                        labelText: 'Monto (USD)',
                        hintText: '150.00',
                      ),
                      validator: (val) => (val == null || val.trim().isEmpty)
                          ? 'Requerido'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _daysController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration.copyWith(
                        labelText: 'Impacto (días)',
                        hintText: '3',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              AppButton(
                text: 'Guardar borrador',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'El borrador no se guardó: el almacenamiento todavía no está conectado.',
                        ),
                      ),
                    );
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
