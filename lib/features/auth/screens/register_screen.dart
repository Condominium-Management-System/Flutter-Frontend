
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/register_cubit.dart';
import '../cubits/register_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/email_field_form.dart';
import '../widgets/password_field_form.dart';
import '../widgets/phone_field_form.dart';
import '../widgets/name_field_form.dart';
import '../widgets/fan_field_form.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/password_requirements.dart';
import '../widgets/auth_loading_indicator.dart';
import '../widgets/auth_error_widget.dart';
import '../widgets/auth_success_dialog.dart';
import '../config/auth_routes.dart';
import '../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fanController = TextEditingController();
  final _condoCodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fanController.dispose();
    _condoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AuthSuccessDialog.show(
            context,
            title: 'Registration Successful!',
            message: 'Welcome to HomeAxis. Please login to continue.',
            buttonText: 'Login',
            onButtonPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AuthRoutes.login,
                (route) => false,
              );
            },
          );
          context.read<RegisterCubit>().reset();
        }
        if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'An error occurred'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return Scaffold(
            body: const AuthLoadingIndicator(
              message: 'Creating your account...',
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
            title: const Text('Create Account'),
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

                    // Full Name
                    NameField(
                      controller: _nameController,
                      label: 'Full Name',
                      hintText: 'Enter your full name',
                    ),
                    const SizedBox(height: 16),

                    // Email
                    EmailField(
                      controller: _emailController,
                      label: 'Email Address',
                      hintText: 'Enter your email address',
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    PhoneField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hintText: 'Enter your phone number',
                    ),
                    const SizedBox(height: 16),

                    // Password
                    PasswordField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: 'Create a strong password',
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
                      label: 'Confirm Password',
                      hintText: 'Confirm your password',
                      isConfirmPassword: true,
                      passwordToMatch: _passwordController.text,
                    ),
                    const SizedBox(height: 16),

                    // FAN Number
                    FANField(
                      controller: _fanController,
                      label: 'FAN Number',
                      hintText: 'Enter your FAN number',
                    ),
                    const SizedBox(height: 16),

                    // Condo Code
                    _buildCondoCodeField(),
                    const SizedBox(height: 24),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state is RegisterLoading ? null : _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGold,
                          foregroundColor: AppColors.primaryBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is RegisterLoading
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
                                'CREATE ACCOUNT',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AuthRoutes.login);
                          },
                          child: Text(
                            'Sign In',
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

  Widget _buildCondoCodeField() {
    return TextFormField(
      controller: _condoCodeController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Condominium code is required';
        }
        if (value.length < 5) {
          return 'Please enter a valid condominium code';
        }
        return null;
      },
      style: TextStyle(
        color: AppColors.textWhite,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: 'Condominium Code',
        hintText: 'Enter your condo code (e.g., YEKONDO-001)',
        hintStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 16,
        ),
        prefixIcon: Icon(
          Icons.apartment,
          color: AppColors.primaryGold,
          size: 24,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryGold.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryGold,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.errorRed,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.errorRed,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        helperText: 'Ask your condo admin for the correct code',
        helperStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 12,
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().register(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            fan: _fanController.text.trim(),
            password: _passwordController.text.trim(),
            condoCode: _condoCodeController.text.trim(),
          );
    }
  }
}