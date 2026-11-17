import 'package:flutter/material.dart';
import '../../data/models/request_status.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({required this.status, super.key});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    final statusColor = status.color;

    return Semantics(
      label: 'Estado: ${status.label}',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(status.icon, size: 14, color: statusColor),
            const SizedBox(width: 5),
            Text(
              status.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
