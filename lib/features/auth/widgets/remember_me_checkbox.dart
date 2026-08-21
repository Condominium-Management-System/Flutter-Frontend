
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';

class RememberMeCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMeCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryGold,
          checkColor: AppColors.primaryBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(
            color: AppColors.primaryGold,
            width: 2,
          ),
        ),
        Text(
          'Remember Me',
          style: TextStyle(
            color: isDark ? AppColors.textWhite : AppColors.textPrimaryLight,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}