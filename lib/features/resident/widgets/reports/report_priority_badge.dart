
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportPriorityBadge extends StatelessWidget {
  final String priority;

  const ReportPriorityBadge({
    super.key,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getPriorityColor(priority);
    final label = _getPriorityLabel(priority);

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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'emergency':
        return AppColors.errorRed;
      case 'high':
        return AppColors.warningYellow;
      case 'medium':
        return AppColors.primaryGold;
      case 'low':
        return AppColors.successGreen;
      default:
        return AppColors.textGray;
    }
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case 'emergency':
        return 'Emergency';
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return priority;
    }
  }
}