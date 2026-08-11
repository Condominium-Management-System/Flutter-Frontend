
import '../../../core/utils/validators.dart';

class NameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required.';
    }
    
    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return 'Name must be at least 2 characters.';
    }
    
    if (trimmed.length > 50) {
      return 'Name must be less than 50 characters.';
    }
    
    // Check if name contains only letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmed)) {
      return 'Name can only contain letters and spaces.';
    }
    
    return null;
  }

  static bool isValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return Validators.isValidName(value.trim());
  }
}