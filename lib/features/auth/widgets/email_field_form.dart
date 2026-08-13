
// ignore_for_file: duplicate_import, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_axis/features/auth/validators/email_validators.dart';
import '../../../shared/theme/colors.dart';
import '../validators/email_validators.dart';
  
class EmailField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const EmailField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hintText,
    this.enabled = true,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      onChanged: onChanged,
      validator: validator ?? (value) => EmailValidator.validate(value),
      style: TextStyle(
        color: enabled ? AppColors.textWhite : AppColors.textDark,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label ?? 'Email Address',
        hintText: hintText ?? 'Enter your email address',
        hintStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 16,
        ),
        prefixIcon: Icon(
          Icons.email_outlined,
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
        fillColor: enabled ? AppColors.inputBackground : AppColors.secondaryBlack,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}