import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

enum RequestStatus {
  draft('Borrador'),
  pending('Enviada'),
  approved('Aprobada'),
  rejected('Rechazada'),
  expired('Vencida'),
  revoked('Revocada');

  const RequestStatus(this.label);
  final String label;

  IconData get icon {
    switch (this) {
      case RequestStatus.draft:
        return Icons.edit_note_outlined;
      case RequestStatus.pending:
        return Icons.schedule_outlined;
      case RequestStatus.approved:
        return Icons.check_circle_outline;
      case RequestStatus.rejected:
        return Icons.cancel_outlined;
      case RequestStatus.expired:
        return Icons.timer_off_outlined;
      case RequestStatus.revoked:
        return Icons.block_outlined;
    }
  }

  Color get color {
    switch (this) {
      case RequestStatus.draft:
        return AppColors.neutralMuted;
      case RequestStatus.pending:
        return AppColors.pending;
      case RequestStatus.approved:
        return AppColors.approved;
      case RequestStatus.rejected:
        return AppColors.error;
      case RequestStatus.expired:
        return AppColors.neutralMuted;
      case RequestStatus.revoked:
        return AppColors.error;
    }
  }
}
