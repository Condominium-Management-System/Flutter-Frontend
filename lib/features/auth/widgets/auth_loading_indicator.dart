
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';

class AuthLoadingIndicator extends StatelessWidget {
  final String? message;

  const AuthLoadingIndicator({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGold),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}