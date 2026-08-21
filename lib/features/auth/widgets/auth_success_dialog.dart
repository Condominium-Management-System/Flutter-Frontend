
import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';
import '../../../shared/theme/theme_colors.dart';

class AuthSuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const AuthSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ThemeColors.dialogBackground(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.successGreen.withOpacity(0.1),
              ),
              child: Icon(
                Icons.check_circle,
                color: AppColors.successGreen,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
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
            if (buttonText != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onButtonPressed ?? () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primaryButtonBg(context),
                    foregroundColor: ThemeColors.primaryButtonFg(context),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(buttonText!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AuthSuccessDialog(
        title: title,
        message: message,
        buttonText: buttonText ?? 'Continue',
        onButtonPressed: onButtonPressed,
      ),
    );
  }
}