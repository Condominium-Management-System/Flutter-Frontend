
// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/profile_cubit.dart';
import '../cubits/profile_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../widgets/auth_loading_indicator.dart';
import '../widgets/auth_error_widget.dart';
import '../widgets/auth_confirmation_dialog.dart';
import '../config/auth_routes.dart';
import '../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: AppColors.successGreen,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: AuthLoadingIndicator(message: 'Loading profile...'),
          );
        }

        if (state is ProfileError) {
          return Scaffold(
            body: AuthErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ProfileCubit>().getProfile();
              },
            ),
          );
        }

        if (state is ProfileLoaded || state is ProfileUpdated) {
          final user = (state as dynamic).user;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AuthRoutes.editProfile,
                      arguments: user,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => _showLogoutConfirmation(context),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primaryGold.withOpacity(0.1),
                    child: user.profilePhoto != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              user.profilePhoto!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 50,
                                  color: AppColors.primaryGold,
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.primaryGold,
                          ),
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Text(
                    user.fullName,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Email
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: user.isVerified
                          ? AppColors.successGreen.withOpacity(0.1)
                          : AppColors.warningYellow.withOpacity(0.1),
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
                  // Stats Row
                  Row(
                    children: [
                      _buildStatItem(
                        label: 'FAN',
                        value: user.fan ?? 'N/A',
                      ),
                      _buildStatItem(
                        label: 'Unit',
                        value: '${user.block ?? ''} - ${user.roomNo ?? ''}',
                      ),
                      _buildStatItem(
                        label: 'Role',
                        value: user.role,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Menu Items
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AuthRoutes.editProfile,
                        arguments: user,
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.pushNamed(context, AuthRoutes.changePassword);
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notification Settings',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'App Settings',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.description_outlined,
                    title: 'Terms & Privacy',
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
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.secondaryBlack,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value.isEmpty || value == 'null' ? 'N/A' : value,
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primaryGold,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textWhite,
          fontSize: 15,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textDark,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    AuthConfirmationDialog.show(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
      isDanger: true,
      onConfirm: () {
        context.read<AuthBloc>().add(AuthLogoutRequested());
      },
    );
  }
}