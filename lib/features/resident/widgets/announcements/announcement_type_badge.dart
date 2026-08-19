
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementTypeBadge extends StatelessWidget {
  final String type;

  const AnnouncementTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor(type);
    final label = _getTypeLabel(type);
    final icon = _getTypeIcon(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'general':
        return AppColors.infoBlue;
      case 'shop_alert':
        return AppColors.warningYellow;
      case 'emergency':
        return AppColors.errorRed;
      case 'event':
        return AppColors.primaryGold;
      case 'mourning':
        return AppColors.textDark;
      case 'celebration':
        return AppColors.successGreen;
      default:
        return AppColors.textGray;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'general':
        return 'General';
      case 'shop_alert':
        return 'Shop Alert';
      case 'emergency':
        return 'Emergency';
      case 'event':
        return 'Event';
      case 'mourning':
        return 'Mourning';
      case 'celebration':
        return 'Celebration';
      default:
        return type;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'general':
        return Icons.info_outline;
      case 'shop_alert':
        return Icons.shopping_bag_outlined;
      case 'emergency':
        return Icons.warning_amber_outlined;
      case 'event':
        return Icons.event_outlined;
      case 'mourning':
        return Icons.heart_broken_outlined;
      case 'celebration':
        return Icons.celebration_outlined;
      default:
        return Icons.announcement_outlined;
    }
  }
}