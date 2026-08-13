
// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;
  final VoidCallback? onOtherTap;

  const SocialLoginButtons({
    super.key,
    this.onGoogleTap,
    this.onAppleTap,
    this.onOtherTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColors.primaryGold.withOpacity(0.3),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppColors.primaryGold.withOpacity(0.3),
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Social Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.g_mobiledata,
              label: 'Google',
              onTap: onGoogleTap,
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.apple,
              label: 'Apple',
              onTap: onAppleTap,
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.phone_android_outlined,
              label: 'Other',
              onTap: onOtherTap,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryGold,
                width: 1.5,
              ),
              color: AppColors.secondaryBlack,
            ),
            child: Icon(
              icon,
              color: label == 'Other' ? AppColors.primaryGold : AppColors.textWhite,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textGray,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}