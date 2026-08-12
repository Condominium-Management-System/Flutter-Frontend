
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/auth/models/change_password_model.dart';
import '../cubits/profile_cubit.dart';
import '../cubits/profile_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/password_field_form.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/password_requirements.dart';
import '../widgets/auth_loading_indicator.dart';
import '../widgets/auth_error_widget.dart';
import '../widgets/auth_success_dialog.dart';
import '../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthChangePasswordSuccess) {
          AuthSuccessDialog.show(
            context,
            title: 'Password Changed!',
            message: 'Your password has been changed successfully.',
            buttonText: 'Continue',
            onButtonPressed: () {
              Navigator.pop(context);
            },
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const AuthLoadingIndicator(
                message: 'Changing password...',
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Current Password
                    PasswordField(
                      controller: _currentPasswordController,
                      label: 'Current Password',
                      hintText: 'Enter your current password',
                    ),
                    const SizedBox(height: 16),
                    // New Password
                    PasswordField(
                      controller: _newPasswordController,
                      label: 'New Password',
                      hintText: 'Enter new password',
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    // Password Strength
                    if (_newPasswordController.text.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      PasswordStrengthIndicator(
                        password: _newPasswordController.text,
                      ),
                    ],
                    // Password Requirements
                    if (_newPasswordController.text.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      PasswordRequirements(
                        password: _newPasswordController.text,
                      ),
                    ],
                    const SizedBox(height: 16),
                    // Confirm Password
                    PasswordField(
                      controller: _confirmPasswordController,
                      label: 'Confirm New Password',
                      hintText: 'Confirm your new password',
                      isConfirmPassword: true,
                      passwordToMatch: _newPasswordController.text,
                    ),
                    const SizedBox(height: 24),
                    // Change Password Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _handleChangePassword,
                        child: Text(
                          'CHANGE PASSWORD',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleChangePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthChangePasswordRequested(
              request: ChangePasswordRequest(
                oldPassword: _currentPasswordController.text.trim(),
                newPassword: _newPasswordController.text.trim(),
              ),
            ),
          );
    }
  }
}