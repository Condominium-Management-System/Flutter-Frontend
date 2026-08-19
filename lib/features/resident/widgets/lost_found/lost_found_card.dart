
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resident/models/lost_found_model.dart';
import 'lost_found_status_badge.dart';
import 'lost_found_type_badge.dart';

class LostFoundCard extends StatelessWidget {
  final LostFoundModel item;
  final VoidCallback onTap;

  const LostFoundCard({
    super.key,
    required this.item,
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
            color: isDark ? AppColors.primaryGold.withOpacity(0.1) : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isDark ? AppColors.inputBackground : AppColors.inputBackgroundLight,
                borderRadius: BorderRadius.circular(8),
                image: item.photoUrl != null
                    ? DecorationImage(
                        image: NetworkImage(item.photoUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: item.photoUrl == null
                  ? Icon(
                      item.isLost ? Icons.search_off : Icons.search,
                      color: AppColors.primaryGold,
                      size: 28,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textWhite : AppColors.textPrimaryLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isDark ? AppColors.textGray : AppColors.textSecondaryLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      LostFoundTypeBadge(type: item.type),
                      const SizedBox(width: 8),
                      LostFoundStatusBadge(status: item.status),
                      const SizedBox(width: 8),
                      Text(
                        _getTimeAgo(item.createdAt),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: isDark ? AppColors.textDark : AppColors.textSecondaryLight,
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

  String _getTimeAgo(String timestamp) {
    // Simple placeholder - will use actual date formatter
    return '2h ago';
  }
}