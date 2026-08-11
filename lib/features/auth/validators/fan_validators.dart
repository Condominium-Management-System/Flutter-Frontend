
// ignore_for_file: constant_identifier_names

class FANValidator {
  static const int FAN_LENGTH = 16;
  static const String FAN_PATTERN = r'^[0-9A-Z]{16}$'; // Allow digits and uppercase letters
  static const String FAN_FORMAT = 'XXXXXXXXXXXXXXXX';

  // ✅ Main validate method
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'FAN number is required.';
    }

    final trimmed = value.trim();
    final cleaned = trimmed.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();

    if (cleaned.isEmpty) {
      return 'Please enter your FAN number.';
    }

    if (cleaned.length != FAN_LENGTH) {
      return 'FAN must be exactly 16 characters. You entered ${cleaned.length}.';
    }

    if (!RegExp(FAN_PATTERN).hasMatch(cleaned)) {
      return 'Only digits and letters (A-Z) are allowed.';
    }

    return null;
  }

  // Check if FAN is valid (returns bool)
  static bool isValid(String? value) {
    if (value == null || value.isEmpty) return false;
    final cleaned = value.trim().replaceAll(RegExp(r'[\s-]'), '').toUpperCase();
    return cleaned.length == FAN_LENGTH && RegExp(FAN_PATTERN).hasMatch(cleaned);
  }

  // Format FAN (just uppercase, no hyphens)
  static String format(String value) {
    return value.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();
  }

  // Auto-format (just remove spaces/hyphens and uppercase)
  static String autoFormat(String value) {
    return value.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();
  }

  // Remove all hyphens and spaces (get raw value)
  static String unformat(String value) {
    return value.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();
  }
}