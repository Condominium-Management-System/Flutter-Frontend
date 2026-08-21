import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardQuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const DashboardQuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (color ?? AppColors.primaryGold).withOpacity(isDark ? 0.1 : 0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.primaryGold.withOpacity(0.1) : AppColors.borderLight,
              ),
            ),
            child: Icon(
              icon,
              color: color ?? AppColors.primaryGold,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textGray : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}