
// ignore_for_file: duplicate_import, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:home_axis/features/auth/validators/password_validators.dart';
import '../../../shared/theme/colors.dart';
import '../validators/password_validators.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGold.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Requirements',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildRequirement(
            'Minimum 8 characters',
            PasswordValidator.hasMinimumLength(password),
          ),
          _buildRequirement(
            'Uppercase letter (A-Z)',
            PasswordValidator.hasUppercase(password),
          ),
          _buildRequirement(
            'Lowercase letter (a-z)',
            PasswordValidator.hasLowercase(password),
          ),
          _buildRequirement(
            'Number (0-9)',
            PasswordValidator.hasNumber(password),
          ),
          _buildRequirement(
            'Special character (!@#\$%^&*)',
            PasswordValidator.hasSpecialCharacter(password),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.cancel_outlined,
            color: isMet ? AppColors.successGreen : AppColors.textDark,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: isMet ? AppColors.successGreen : AppColors.textDark,
              fontSize: 13,
              decoration: isMet ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}