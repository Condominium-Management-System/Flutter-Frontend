
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final VoidCallback? onCopy;
  final bool isVerified;

  const ProfileInfoItem({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.onCopy,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: AppColors.primaryGold,
              size: 20,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textGray,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        value.isEmpty || value == 'null' ? 'N/A' : value,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                    if (isVerified)
                      Icon(
                        Icons.verified,
                        color: AppColors.successGreen,
                        size: 16,
                      ),
                    if (onCopy != null)
                      IconButton(
                        icon: Icon(
                          Icons.copy,
                          color: AppColors.primaryGold,
                          size: 16,
                        ),
                        onPressed: onCopy,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.only(left: 8),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}