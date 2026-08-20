
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';

class NotificationTypeIcon extends StatelessWidget {
  final String type;

  const NotificationTypeIcon({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = _getIconData(type);
    final color = _getColor(type);

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 20,
      ),
    );
  }

  IconData _getIconData(String type) {
    switch (type) {
      case 'payment':
        return Icons.payments_outlined;
      case 'announcement':
        return Icons.announcement_outlined;
      case 'report':
        return Icons.report_problem_outlined;
      case 'equb':
        return Icons.attach_money;
      case 'iddir':
        return Icons.people_outline;
      case 'lost_found':
        return Icons.search_outlined;
      case 'system':
        return Icons.settings_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'payment':
        return AppColors.successGreen;
      case 'announcement':
        return AppColors.infoBlue;
      case 'report':
        return AppColors.errorRed;
      case 'equb':
        return AppColors.primaryGold;
      case 'iddir':
        return AppColors.primaryGold;
      case 'lost_found':
        return AppColors.warningYellow;
      case 'system':
        return AppColors.textGray;
      default:
        return AppColors.primaryGold;
    }
  }
}