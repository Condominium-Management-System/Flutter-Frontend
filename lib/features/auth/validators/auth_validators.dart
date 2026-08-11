
// ignore_for_file: constant_identifier_names

class FANValidator {
  static const int FAN_LENGTH = 16; // Changed from 12 to 16
  static const String FAN_PATTERN = r'^[0-9A-Z]{16}$'; // Allow digits and uppercase letters
  static const String FAN_FORMAT = 'XXXX-XXXX-XXXX-XXXX';

  // ✅ Main validate method
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'FAN number is required.';
    }

    final trimmed = value.trim();
    final cleaned = trimmed.replaceAll('-', '').toUpperCase();

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
    final cleaned = value.trim().replaceAll('-', '').toUpperCase();
    return cleaned.length == FAN_LENGTH && RegExp(FAN_PATTERN).hasMatch(cleaned);
  }

  // Format FAN with hyphens for display
  static String format(String value) {
    final cleaned = value.replaceAll('-', '').toUpperCase();
    if (cleaned.length >= FAN_LENGTH) {
      return '${cleaned.substring(0, 4)}-${cleaned.substring(4, 8)}-${cleaned.substring(8, 12)}-${cleaned.substring(12, 16)}';
    }
    return value;
  }

  // Auto-format as user types
  static String autoFormat(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9A-Z]'), '').toUpperCase();
    
    if (cleaned.length <= 4) {
      return cleaned;
    } else if (cleaned.length <= 8) {
      return '${cleaned.substring(0, 4)}${cleaned.substring(4)}';
    } else if (cleaned.length <= 12) {
      return '${cleaned.substring(0, 4)}${cleaned.substring(4, 8)}${cleaned.substring(8)}';
    } else {
      return '${cleaned.substring(0, 4)}${cleaned.substring(4, 8)}${cleaned.substring(8, 12)}${cleaned.substring(12, cleaned.length > 16 ? 16 : cleaned.length)}';
    }
  }

  // Remove all hyphens (get raw value)
  static String unformat(String value) {
    return value.replaceAll('', '').toUpperCase();
  }
}