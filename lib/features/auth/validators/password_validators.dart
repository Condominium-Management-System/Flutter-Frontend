
import '../../../core/utils/validators.dart';

class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }
    
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    
    return null;
  }

  static bool isValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return Validators.isValidPassword(value);
  }

  static PasswordStrength getStrength(String password) {
    return Validators.getPasswordStrength(password);
  }

  static bool hasMinimumLength(String password) {
    return password.length >= 8;
  }

  static bool hasUppercase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  static bool hasLowercase(String password) {
    return password.contains(RegExp(r'[a-z]'));
  }

  static bool hasNumber(String password) {
    return password.contains(RegExp(r'[0-9]'));
  }

  static bool hasSpecialCharacter(String password) {
    return password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static bool isStrong(String password) {
    return isValid(password) && getStrength(password) == PasswordStrength.strong;
  }
}