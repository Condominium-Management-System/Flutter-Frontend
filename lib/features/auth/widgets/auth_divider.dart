

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';

class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider({
    super.key,
    this.text = 'Or continue with',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            text,
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
    );
  }
}