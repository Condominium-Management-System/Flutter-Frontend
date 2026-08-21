// lib/features/auth/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/login_cubit.dart';
import '../cubits/login_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/email_field_form.dart';
import '../widgets/password_field_form.dart';
import '../widgets/socilal_login_buttons.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/remember_me_checkbox.dart';
import '../widgets/auth_loading_indicator.dart';
import '../widgets/auth_error_widget.dart';
import '../config/auth_routes.dart';
import '../../resident/config/resident_routes.dart';  
import '../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().loadSavedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, ResidentRoutes.home);
        } else if (state is LoginRememberMeLoaded) {
          _emailController.text = state.email;
          _passwordController.text = state.password;
          _rememberMe = state.rememberMe;
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return Scaffold(
            body: const AuthLoadingIndicator(message: 'Signing in...'),
          );
        }

        if (state is LoginError) {
          return Scaffold(
            body: AuthErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<LoginCubit>().clearError();
              },
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const AuthHeader(subtitle: 'Sign in to continue'),
                    const SizedBox(height: 40),
                    EmailField(
                      controller: _emailController,
                      label: 'Email or Phone Number',
                      hintText: 'Enter your email or phone',
                      enabled: state is! LoginLoading,
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: 'Enter your password',
                      enabled: state is! LoginLoading,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RememberMeCheckbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        ForgotPasswordLink(
                          onTap: () {
                            Navigator.pushNamed(context, AuthRoutes.forgotPassword);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state is LoginLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGold,
                          foregroundColor: AppColors.primaryBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is LoginLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryBlack,
                                  ),
                                ),
                              )
                            : Text(
                                'SIGN IN',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SocialLoginButtons(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.textGray
                                : AppColors.textSecondaryLight,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AuthRoutes.register);
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: AppColors.primaryGold,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terms of Service  |  Privacy Policy',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textDark
                            : AppColors.textSecondaryLight,
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

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            rememberMe: _rememberMe,
          );
    }
  }
}