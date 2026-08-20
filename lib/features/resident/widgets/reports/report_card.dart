
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resident/models/report_model.dart';
import 'report_status_badge.dart';
import 'report_priority_badge.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.report,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.secondaryBlack : AppColors.secondaryLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getPriorityColor(report.priority).withOpacity(isDark ? 0.2 : 0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    report.title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textWhite : AppColors.textPrimaryLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                ReportPriorityBadge(priority: report.priority),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              report.description,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: isDark ? AppColors.textGray : AppColors.textSecondaryLight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGold.withOpacity(isDark ? 0.1 : 0.18),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        report.categoryLabel,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ReportStatusBadge(status: report.status),
                  ],
                ),
                Text(
                  _getTimeAgo(report.createdAt),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: isDark ? AppColors.textDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
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

  String _getTimeAgo(String timestamp) {
    // Simple placeholder - will use actual date formatter
    return '2h ago';
  }
}