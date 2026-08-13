
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';

class ForgotPasswordLink extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPasswordLink({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: AppColors.primaryGold,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}