
// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';
import '../validators/name_validators.dart';

class NameField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const NameField({
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
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      onChanged: onChanged,
      validator: validator ?? (value) => NameValidator.validate(value),
      style: TextStyle(
        color: enabled ? AppColors.textWhite : AppColors.textDark,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label ?? 'Full Name',
        hintText: hintText ?? 'Enter your full name',
        hintStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 16,
        ),
        prefixIcon: Icon(
          Icons.person_outline,
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