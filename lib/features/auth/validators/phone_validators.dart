
import '../../../core/utils/validators.dart';

class PhoneValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }
    
    final trimmed = value.trim();
    if (!Validators.isValidPhone(trimmed)) {
      return 'Please enter a valid Ethiopian phone number (e.g., 0912345678).';
    }
    
    return null;
  }

  static bool isValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return Validators.isValidPhone(value.trim());
  }

  static String format(String phone) {
    // Format: 0912345678 -> +251 912345678
    final cleaned = phone.replaceAll(RegExp(r'\s'), '');
    if (cleaned.startsWith('0')) {
      return '+251${cleaned.substring(1)}';
    }
    if (cleaned.startsWith('+251')) {
      return cleaned;
    }
    return phone;
  }
}