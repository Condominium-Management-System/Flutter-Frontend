
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/resident_bloc.dart';
import '../../bloc/resident_state.dart';
import '../../bloc/resident_event.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/gold_text_field.dart';
import '../../widgets/common/success_dialog.dart';
import '../../../../shared/theme/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Change Password',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocListener<ResidentBloc, ResidentState>(
        listener: (context, state) {
          if (state is ResidentPasswordChanged) {
            SuccessDialog.show(
              context,
              title: 'Password Changed!',
              message: 'Your password has been changed successfully.',
              buttonText: 'Continue',
              onButtonPressed: () {
                Navigator.pop(context);
              },
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
        },
        child: BlocBuilder<ResidentBloc, ResidentState>(
          builder: (context, state) {
          if (state is ResidentLoading) {
            return const LoadingIndicator(message: 'Changing password...');
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Enter your current password and choose a new one',
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Current Password
                  GoldTextField(
                    label: 'Current Password',
                    isPassword: true,
                    controller: _currentPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Current password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // New Password
                  GoldTextField(
                    label: 'New Password',
                    isPassword: true,
                    controller: _newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'New password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Password must be at least 8 characters',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  GoldTextField(
                    label: 'Confirm New Password',
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Change Button
                  GoldButton(
                    text: 'Change Password',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.large,
                    onPressed: _changePassword,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  void _changePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResidentBloc>().add(
            ResidentChangePassword(
              oldPassword: _currentPasswordController.text.trim(),
              newPassword: _newPasswordController.text.trim(),
            ),
          );
    }
  }
}