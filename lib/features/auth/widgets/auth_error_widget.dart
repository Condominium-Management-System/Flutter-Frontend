
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';
import '../../../shared/theme/theme_colors.dart';

class AuthErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AuthErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.errorRed,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: TextStyle(
                color: ThemeColors.titleColor(context),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.bodyColor(context),
                fontSize: 14,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primaryButtonBg(context),
                  foregroundColor: ThemeColors.primaryButtonFg(context),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}