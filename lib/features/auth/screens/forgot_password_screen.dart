
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/forgot_password_cubit.dart';
import '../cubits/forgot_password_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/email_field_form.dart';
import '../widgets/auth_loading_indicator.dart';
import '../widgets/auth_error_widget.dart';
import '../widgets/auth_success_dialog.dart';
import '../config/auth_routes.dart';
import '../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          AuthSuccessDialog.show(
            context,
            title: 'Reset Link Sent!',
            message: 'Check your email for the link to reset your password.\n\nLink expires in 1 hour.',
            buttonText: 'Back to Login',
            onButtonPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AuthRoutes.login,
                (route) => false,
              );
            },
          );
          context.read<ForgotPasswordCubit>().reset();
        }
      },
      builder: (context, state) {
        if (state is ForgotPasswordLoading) {
          return Scaffold(
            body: const AuthLoadingIndicator(
              message: 'Sending reset link...',
            ),
          );
        }

        if (state is ForgotPasswordError) {
          return Scaffold(
            body: AuthErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ForgotPasswordCubit>().clearError();
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
            title: const Text('Reset Password'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const AuthHeader(),
                    const SizedBox(height: 32),
                    Text(
                      'Enter your email to receive a password reset link',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    EmailField(
                      controller: _emailController,
                      label: 'Email Address',
                      hintText: 'Enter your registered email',
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'We\'ll send a reset link to this email',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _handleForgotPassword,
                        child: Text(
                          'SEND RESET LINK',
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
                        Navigator.pop(context);
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryBlack,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.textDark.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '💡 Tips:',
                            style: TextStyle(
                              color: AppColors.textGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• Check your spam/junk folder\n'
                            '• Make sure you entered the correct email\n'
                            '• The link expires in 1 hour\n'
                            '• Contact support if you don\'t receive the email',
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 12,
                              height: 1.8,
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

  void _handleForgotPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().forgotPassword(
            _emailController.text.trim(),
          );
    }
  }
}