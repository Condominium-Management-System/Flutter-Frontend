
import '../../../core/utils/validators.dart';

class EmailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    
    final trimmed = value.trim();
    if (!Validators.isValidEmail(trimmed)) {
      return 'Please enter a valid email address.';
    }
    
    return null;
  }

  static bool isValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return Validators.isValidEmail(value.trim());
  }
}