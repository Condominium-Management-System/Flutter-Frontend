
import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';

class CondoCodeField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const CondoCodeField({
    super.key,
    this.controller,
    this.initialValue,
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
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Condominium code is required.';
        }
        if (value.length < 5) {
          return 'Please enter a valid condominium code.';
        }
        return null;
      },
      style: TextStyle(
        color: enabled ? AppColors.textWhite : AppColors.textDark,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: 'Condominium Code',
        hintText: 'Enter your condo code (e.g., YK-001)',
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
        fillColor: enabled ? AppColors.inputBackground : AppColors.secondaryBlack,
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
}