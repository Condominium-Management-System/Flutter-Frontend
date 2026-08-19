
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';

enum SnackbarType { success, error, info, warning }

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    final colors = _getColors(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _getIcon(type),
              color: colors.text,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colors.background,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        action: onAction != null && actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: colors.text,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }

  static _SnackbarColors _getColors(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarColors(
          background: AppColors.successGreen,
          text: AppColors.textWhite,
        );
      case SnackbarType.error:
        return _SnackbarColors(
          background: AppColors.errorRed,
          text: AppColors.textWhite,
        );
      case SnackbarType.warning:
        return _SnackbarColors(
          background: AppColors.warningYellow,
          text: AppColors.primaryBlack,
        );
      case SnackbarType.info:
        return _SnackbarColors(
          background: AppColors.infoBlue,
          text: AppColors.textWhite,
        );
    }
  }

  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle_outline;
      case SnackbarType.error:
        return Icons.error_outline;
      case SnackbarType.warning:
        return Icons.warning_amber_outlined;
      case SnackbarType.info:
        return Icons.info_outline;
    }
  }
}

class _SnackbarColors {
  final Color background;
  final Color text;

  _SnackbarColors({
    required this.background,
    required this.text,
  });
}