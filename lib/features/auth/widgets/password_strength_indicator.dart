
// ignore_for_file: duplicate_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_axis/core/utils/validators.dart';
import 'package:home_axis/features/auth/validators/password_validators.dart';
import '../../../shared/theme/colors.dart';
import '../validators/password_validators.dart';
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final strength = PasswordValidator.getStrength(password);
    final strengthValue = _getStrengthValue(strength);
    final strengthColor = _getStrengthColor(strength);
    final strengthLabel = _getStrengthLabel(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: strengthValue,
            backgroundColor: AppColors.secondaryBlack,
            valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 8),
        // Strength Label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password Strength',
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 13,
              ),
            ),
            Text(
              strengthLabel,
              style: TextStyle(
                color: strengthColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        // Requirements Check (only show if password is not empty)
        if (password.isNotEmpty) ...[
          const SizedBox(height: 12),
          _buildRequirement(
            'At least 8 characters',
            PasswordValidator.hasMinimumLength(password),
          ),
          _buildRequirement(
            'Uppercase letter',
            PasswordValidator.hasUppercase(password),
          ),
          _buildRequirement(
            'Lowercase letter',
            PasswordValidator.hasLowercase(password),
          ),
          _buildRequirement(
            'Number',
            PasswordValidator.hasNumber(password),
          ),
          _buildRequirement(
            'Special character',
            PasswordValidator.hasSpecialCharacter(password),
          ),
        ],
      ],
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.cancel_outlined,
            color: isMet ? AppColors.successGreen : AppColors.textDark,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isMet ? AppColors.successGreen : AppColors.textDark,
              fontSize: 12,
              decoration: isMet ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }

  double _getStrengthValue(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 0.25;
      case PasswordStrength.medium:
        return 0.50;
      case PasswordStrength.good:
        return 0.75;
      case PasswordStrength.strong:
        return 1.0;
    }
  }

  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return AppColors.errorRed;
      case PasswordStrength.medium:
        return AppColors.warningYellow;
      case PasswordStrength.good:
        return AppColors.primaryGold;
      case PasswordStrength.strong:
        return AppColors.successGreen;
    }
  }

  String _getStrengthLabel(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.good:
        return 'Good';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }
}