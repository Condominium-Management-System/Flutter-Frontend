
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonVariant { primary, secondary, outline, danger, success }

enum ButtonSize { small, medium, large }

class GoldButton extends StatelessWidget {
  final String text;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final double? width;

  const GoldButton({
    super.key,
    required this.text,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final padding = _getPadding();

    return SizedBox(
      width: width ?? double.infinity,
      height: _getHeight(),
      child: Container(
        decoration: BoxDecoration(
          gradient: colors.background is Gradient ? colors.background as Gradient : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: isDisabled || isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.background is Color ? colors.background as Color : Colors.transparent,
            foregroundColor: colors.foreground,
            disabledBackgroundColor: colors.disabledBackground,
            disabledForegroundColor: colors.disabledForeground,
            elevation: variant == ButtonVariant.primary ? 8 : 0,
            shadowColor: variant == ButtonVariant.primary
                ? AppColors.primaryGold.withOpacity(0.3)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: colors.border ?? Colors.transparent,
                width: 1.5,
              ),
            ),
            padding: padding,
          ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colors.loaderColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: _getIconSize()),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: _getFontSize(),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    ));
  }

  _ButtonColors _getColors() {
    switch (variant) {
      case ButtonVariant.primary:
        return _ButtonColors(
          background: const LinearGradient(
            colors: [AppColors.primaryGold, AppColors.secondaryGold],
          ),
          foreground: AppColors.primaryBlack,
          disabledBackground: AppColors.textDark,
          disabledForeground: AppColors.textGray,
          border: null,
          loaderColor: AppColors.primaryBlack,
        );
      case ButtonVariant.secondary:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.primaryGold,
          disabledBackground: Colors.transparent,
          disabledForeground: AppColors.textDark,
          border: AppColors.primaryGold,
          loaderColor: AppColors.primaryGold,
        );
      case ButtonVariant.outline:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.textWhite,
          disabledBackground: Colors.transparent,
          disabledForeground: AppColors.textDark,
          border: AppColors.textDark,
          loaderColor: AppColors.textWhite,
        );
      case ButtonVariant.danger:
        return _ButtonColors(
          background: AppColors.errorRed,
          foreground: AppColors.textWhite,
          disabledBackground: AppColors.textDark,
          disabledForeground: AppColors.textGray,
          border: null,
          loaderColor: AppColors.textWhite,
        );
      case ButtonVariant.success:
        return _ButtonColors(
          background: AppColors.successGreen,
          foreground: AppColors.textWhite,
          disabledBackground: AppColors.textDark,
          disabledForeground: AppColors.textGray,
          border: null,
          loaderColor: AppColors.textWhite,
        );
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 18);
    }
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }
}

class _ButtonColors {
  final Object? background;
  final Color foreground;
  final Color disabledBackground;
  final Color disabledForeground;
  final Color? border;
  final Color loaderColor;

  _ButtonColors({
    this.background,
    required this.foreground,
    required this.disabledBackground,
    required this.disabledForeground,
    this.border,
    required this.loaderColor,
  });
}