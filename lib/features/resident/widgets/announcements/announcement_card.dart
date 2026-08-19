
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resident/models/announcement_model.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  final VoidCallback onTap;
  final bool isPinned;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.onTap,
    this.isPinned = false,
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
            color: isPinned
                ? AppColors.primaryGold
                : (isDark ? AppColors.primaryGold.withOpacity(0.1) : AppColors.borderLight),
            width: isPinned ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getTypeColor(announcement.announcementType)
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    announcement.typeLabel,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: _getTypeColor(announcement.announcementType),
                    ),
                  ),
                ),
                if (isPinned) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.push_pin,
                    color: AppColors.primaryGold,
                    size: 14,
                  ),
                ],
                const Spacer(),
                Text(
                  _getTimeAgo(announcement.createdAt),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: isDark ? AppColors.textDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              announcement.title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textWhite : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              announcement.body,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: isDark ? AppColors.textGray : AppColors.textSecondaryLight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              'By ${announcement.createdByRole}',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: isDark ? AppColors.textDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'emergency':
        return AppColors.errorRed;
      case 'event':
        return AppColors.infoBlue;
      case 'celebration':
        return AppColors.successGreen;
      case 'mourning':
        return AppColors.textDark;
      case 'shop_alert':
        return AppColors.warningYellow;
      default:
        return AppColors.primaryGold;
    }
  }

  String _getTimeAgo(String timestamp) {
    // Simple placeholder - will use actual date formatter
    return '2h ago';
  }
}