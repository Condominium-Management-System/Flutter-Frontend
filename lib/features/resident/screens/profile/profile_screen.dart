
// ignore_for_file: unnecessary_cast, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/services/auth_service.dart';
import '../../bloc/resident_bloc.dart';
import '../../bloc/resident_state.dart';
import '../../bloc/resident_event.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/confirmation_dialog.dart';
import '../../widgets/profile/profile_avatar.dart';
import '../../widgets/profile/profile_info_item.dart';
import '../../widgets/profile/profile_menu_item.dart';
import '../../../../shared/theme/colors.dart';
import '../../../auth/config/auth_routes.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResidentBloc()..add(ResidentGetProfile()),
      child: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatefulWidget {
  const _ProfileContent();

  @override
  State<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Profile',
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<ResidentBloc, ResidentState>(
        listener: (context, state) {
          if (state is ResidentProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: AppColors.successGreen,
              ),
            );
          }
          if (state is ResidentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
          // ✅ ADD THIS: Navigate to login when logged out
          if (state is ResidentLoggedOut || state is ResidentUnauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AuthRoutes.login,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is ResidentLoading) {
            return const LoadingIndicator(message: 'Loading profile...');
          }

          if (state is ResidentError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ResidentBloc>().add(ResidentGetProfile());
              },
            );
          }

          if (state is ResidentProfileLoaded || state is ResidentAuthenticated) {
            final user = state is ResidentProfileLoaded
                ? (state as ResidentProfileLoaded).user
                : (state as ResidentAuthenticated).user;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Avatar
                  ProfileAvatar(
                    imageUrl: user.profilePhoto,
                    name: user.fullName,
                    size: 100,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Name
                  Text(
                    user.fullName,
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Verified Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: user.isVerified
                          ? AppColors.successGreen.withOpacity(0.15)
                          : AppColors.warningYellow.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          user.isVerified ? Icons.verified : Icons.warning_amber,
                          color: user.isVerified
                              ? AppColors.successGreen
                              : AppColors.warningYellow,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          user.isVerified ? 'Verified' : 'Pending Verification',
                          style: TextStyle(
                            color: user.isVerified
                                ? AppColors.successGreen
                                : AppColors.warningYellow,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Info Items
                  ProfileInfoItem(
                    label: 'Phone',
                    value: user.phoneNumber,
                    icon: Icons.phone_outlined,
                  ),
                  ProfileInfoItem(
                    label: 'Unit',
                    value: user.block != null && user.roomNo != null
                        ? '${user.block} - ${user.roomNo}'
                        : 'Not Assigned',
                    icon: Icons.home_outlined,
                  ),
                  ProfileInfoItem(
                    label: 'FAN Number',
                    value: user.fan ?? 'N/A',
                    icon: Icons.numbers_outlined,
                  ),
                  ProfileInfoItem(
                    label: 'Member Since',
                    value: user.registerDate?.substring(0, 10) ?? 'N/A',
                    icon: Icons.calendar_today_outlined,
                  ),
                  const SizedBox(height: 24),

                  // Menu Items
                  ProfileMenuItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notification Settings',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'App Settings',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => _showLogoutConfirmation(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.errorRed,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.errorRed,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'App Version 1.0.0',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    ConfirmationDialog.show(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
      isDanger: true,
      onConfirm: () {
        context.read<ResidentBloc>().add(ResidentLogout());
      },
    );
  }
}