
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/theme/colors.dart';

class AuthHeader extends StatelessWidget {
  final String? subtitle;
  final double logoSize;

  const AuthHeader({
    super.key,
    this.subtitle,
    this.logoSize = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: AppColors.primaryGold.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryGold,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.apartment,
            color: AppColors.primaryGold,
            size: logoSize * 0.6,
          ),
        ),
        const SizedBox(height: 16),
        // App Name
        Text(
          'YE KONDOMINIUM',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        // Subtitle
        if (subtitle != null) ...[
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors.textGray,
            ),
          ),
        ],
      ],
    );
  }
}