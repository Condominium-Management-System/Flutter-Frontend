
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportStatusBadge extends StatelessWidget {
  final String status;

  const ReportStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(status);
    final label = _getStatusLabel(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'reported':
        return AppColors.infoBlue;
      case 'assigned':
        return AppColors.warningYellow;
      case 'in_progress':
        return AppColors.primaryGold;
      case 'resolved':
        return AppColors.successGreen;
      case 'closed':
        return AppColors.textDark;
      default:
        return AppColors.textGray;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'reported':
        return 'Reported';
      case 'assigned':
        return 'Assigned';
      case 'in_progress':
        return 'In Progress';
      case 'resolved':
        return 'Resolved';
      case 'closed':
        return 'Closed';
      default:
        return status;
    }
  }
}