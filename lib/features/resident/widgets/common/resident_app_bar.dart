
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/widgets/theme_toggle.dart';

class ResidentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final Color backgroundColor;
  final double elevation;

  const ResidentAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.onNotificationTap,
    this.onProfileTap,
    this.backgroundColor = AppColors.primaryGold,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryBlack,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBlack,
        ),
      ),
      actions: actions ?? [
        // Theme toggle
        const ThemeToggle(),
        // Notification Icon
        IconButton(
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: AppColors.primaryBlack,
                size: 24,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.errorRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: onNotificationTap,
        ),
        // Profile Icon
        IconButton(
          icon: const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryGold,
            child: Icon(
              Icons.person,
              color: AppColors.primaryBlack,
              size: 18,
            ),
          ),
          onPressed: onProfileTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}