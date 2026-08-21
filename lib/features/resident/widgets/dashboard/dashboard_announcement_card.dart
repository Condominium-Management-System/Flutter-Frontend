[8/21/2026 5:19 PM] Tommy: import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resident/models/announcement_model.dart';

class DashboardAnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  final VoidCallback onTap;

  const DashboardAnnouncementCard({
    super.key,
    required this.announcement,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondaryBlack,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: announcement.isPinned
                ? AppColors.primaryGold
                : AppColors.primaryGold.withOpacity(0.1),
            width: announcement.isPinned ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            if (announcement.isPinned)
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryGold,
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsets.only(right: 12),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          announcement.title,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textWhite,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (announcement.isPinned)
                        Icon(
                          Icons.push_pin,
                          color: AppColors.primaryGold,
                          size: 16,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    announcement.body.length > 60
                        ? '${announcement.body.substring(0, 60)}...'
                        : announcement.body,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.textGray,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
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
                      const SizedBox(width: 8),
                      Text(
                        _getTimeAgo(announcement.createdAt),
                        style: GoogleFonts.inter(
[8/21/2026 5:19 PM] Tommy: fontSize: 11,
                          fontWeight: FontWeight.normal,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ],
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