
// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_axis/features/auth/validators/confirm_password_validators.dart';
import '../../../shared/theme/colors.dart';
import '../validators/password_validators.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final bool enabled;
  final bool isConfirmPassword;
  final String? passwordToMatch;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const PasswordField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hintText,
    this.enabled = true,
    this.isConfirmPassword = false,
    this.passwordToMatch,
    this.onChanged,
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.controller == null ? widget.initialValue : null,
      enabled: widget.enabled,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      autofillHints: widget.isConfirmPassword
          ? null
          : const [AutofillHints.password],
      onChanged: widget.onChanged,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        if (widget.isConfirmPassword) {
          return ConfirmPasswordValidator.validate(
            value,
            widget.passwordToMatch ?? '',
          );
        }
        return PasswordValidator.validate(value);
      },
      style: TextStyle(
        color: widget.enabled
            ? (isDark ? AppColors.textWhite : AppColors.textPrimaryLight)
            : AppColors.textSecondaryLight,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: widget.label ??
            (widget.isConfirmPassword ? 'Confirm Password' : 'Password'),
        hintText: widget.hintText ??
            (widget.isConfirmPassword
                ? 'Confirm your password'
                : 'Enter your password'),
        hintStyle: TextStyle(
          color: isDark ? AppColors.textDark : AppColors.textSecondaryLight,
          fontSize: 16,
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: AppColors.primaryGold,
          size: 24,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.primaryGold,
            size: 22,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
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
        fillColor: widget.enabled
            ? (isDark ? AppColors.inputBackground : AppColors.inputBackgroundLight)
            : AppColors.secondaryLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}