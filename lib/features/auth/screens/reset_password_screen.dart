
// ignore_for_file: prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/auth/cubits/register_state.dart';
import '../cubits/reset_password_cubit.dart';
import '../cubits/reset_password_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/password_field_form.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/password_requirements.dart';
import '../widgets/auth_loading_indicator.dart';
import '../widgets/auth_error_widget.dart';
import '../widgets/auth_success_dialog.dart';
import '../config/auth_routes.dart';
import '../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.token});

  final String token;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          AuthSuccessDialog.show(
            context,
            title: 'Password Reset Success!',
            message: 'Your password has been successfully updated.\n\nUse your new password to sign in.',
            buttonText: 'Back to Login',
            onButtonPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AuthRoutes.login,
                (route) => false,
              );
            },
          );
          context.read<ResetPasswordCubit>().reset();
        }
      },
      builder: (context, state) {
        if (state is ResetPasswordLoading) {
          return Scaffold(
            body: const AuthLoadingIndicator(
              message: 'Resetting password...',
            ),
          );
        }

        if (state is ResetPasswordError) {
          return Scaffold(
            body: AuthErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ResetPasswordCubit>().clearError();
              },
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Create New Password'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const AuthHeader(),
                    const SizedBox(height: 24),
                    // Security Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGold.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primaryGold.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: AppColors.primaryGold,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '🔐 Secure Reset Link Verified',
                              style: TextStyle(
                                color: AppColors.primaryGold,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.successGreen.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '✓ Valid',
                              style: TextStyle(
                                color: AppColors.successGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Your new password must be different from previously used passwords',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // New Password
                    PasswordField(
                      controller: _passwordController,
                      label: 'New Password',
                      hintText: 'Enter new password',
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    // Password Strength Indicator
                    if (_passwordController.text.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      PasswordStrengthIndicator(
                        password: _passwordController.text,
                      ),
                    ],
                    // Password Requirements
                    if (_passwordController.text.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      PasswordRequirements(
                        password: _passwordController.text,
                      ),
                    ],
                    const SizedBox(height: 16),
                    // Confirm Password
                    PasswordField(
                      controller: _confirmPasswordController,
                      label: 'Confirm New Password',
                      hintText: 'Confirm your new password',
                      isConfirmPassword: true,
                      passwordToMatch: _passwordController.text,
                    ),
                    const SizedBox(height: 24),
                    // Reset Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _handleResetPassword,
                        child: Text(
                          'RESET PASSWORD',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AuthRoutes.login);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Back to Sign In',
                            style: TextStyle(
                              color: AppColors.primaryGold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terms of Service  |  Privacy Policy',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().resetPassword(
            token: widget.token,
            newPassword: _passwordController.text.trim(),
          );
    }
  }
}