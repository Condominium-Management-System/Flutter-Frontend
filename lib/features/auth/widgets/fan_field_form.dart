
// ignore_for_file: unused_import, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';
import '../validators/fan_validators.dart';

class FANField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const FANField({
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
  State<FANField> createState() => _FANFieldState();
}

class _FANFieldState extends State<FANField> {
  late TextEditingController _controller;
  String? _lastFormattedValue;

  // ✅ Validator for 16 characters (no hyphens)
  String? _validateFAN(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a FAN number';
    }

    final normalized = value.replaceAll(RegExp(r'[\s-]'), '').trim().toUpperCase();
    if (normalized.length != 16) {
      return 'FAN must be exactly 16 characters';
    }

    if (!RegExp(r'^[0-9A-Z]+$').hasMatch(normalized)) {
      return 'Only digits and letters are allowed';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null && widget.controller == null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  // ✅ Format: just uppercase, no hyphens
  String _formatFAN(String value) {
    return value.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      enabled: widget.enabled,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      autofillHints: const ['fan'],
      onChanged: (value) {
        final formatted = _formatFAN(value);
        if (_lastFormattedValue != formatted) {
          _lastFormattedValue = formatted;
          _controller.value = _controller.value.copyWith(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }
        if (widget.onChanged != null) {
          widget.onChanged!(_controller.text);
        }
      },
      validator: widget.validator ?? _validateFAN,
      style: TextStyle(
        color: widget.enabled ? AppColors.textWhite : AppColors.textDark,
        fontSize: 16,
        letterSpacing: 1.5, // Slightly increased for readability
      ),
      decoration: InputDecoration(
        labelText: widget.label ?? 'FAN Number',
        hintText: widget.hintText ?? 'Enter 16 characters (digits and letters)',
        hintStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 16,
        ),
        prefixIcon: Icon(
          Icons.numbers_outlined,
          color: AppColors.primaryGold,
          size: 24,
        ),
        suffixIcon: Icon(
          Icons.info_outline,
          color: AppColors.textDark,
          size: 20,
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
        fillColor: widget.enabled ? AppColors.inputBackground : AppColors.secondaryBlack,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        helperText: 'Enter 16 characters (digits and letters A-Z)',
        helperStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 12,
        ),
        counterText: '', // Hide character counter
      ),
      maxLength: 16, // ✅ Limit to exactly 16 characters
    );
  }
}