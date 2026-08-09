
import '../utils/validators.dart';
import '../constants/error_constant.dart';

class ValidationService {
  static final ValidationService _instance = ValidationService._internal();
  factory ValidationService() => _instance;
  ValidationService._internal();

  // Email validation
  ValidationResult validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(ErrorMessages.requiredField);
    }
    if (!Validators.isValidEmail(value.trim())) {
      return ValidationResult.invalid(ErrorMessages.invalidEmail);
    }
    return ValidationResult.valid();
  }

  // Phone validation
  ValidationResult validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(ErrorMessages.requiredField);
    }
    if (!Validators.isValidPhone(value.trim())) {
      return ValidationResult.invalid(ErrorMessages.invalidPhone);
    }
    return ValidationResult.valid();
  }

  // Password validation
  ValidationResult validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(ErrorMessages.requiredField);
    }
    if (value.length < 8) {
      return ValidationResult.invalid('Password must be at least 8 characters.');
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return ValidationResult.invalid('Password must contain at least one uppercase letter.');
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return ValidationResult.invalid('Password must contain at least one lowercase letter.');
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return ValidationResult.invalid('Password must contain at least one number.');
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return ValidationResult.invalid('Password must contain at least one special character.');
    }
    return ValidationResult.valid();
  }

  // Confirm password validation
  ValidationResult validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(ErrorMessages.requiredField);
    }
    if (value != password) {
      return ValidationResult.invalid(ErrorMessages.passwordsDoNotMatch);
    }
    return ValidationResult.valid();
  }

  // Name validation
  ValidationResult validateName(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(ErrorMessages.requiredField);
    }
    if (value.length < 2) {
      return ValidationResult.invalid('Name must be at least 2 characters.');
    }
    if (value.length > 50) {
      return ValidationResult.invalid('Name must be less than 50 characters.');
    }
    return ValidationResult.valid();
  }

  // FAN validation
  ValidationResult validateFAN(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid(ErrorMessages.requiredField);
    }
    if (!Validators.isValidFAN(value.trim())) {
      return ValidationResult.invalid('Please enter a valid FAN number (format: XXXX-XXXX-XXXX)');
    }
    return ValidationResult.valid();
  }

  // Multiple field validation
  ValidationResult validateMultiple(List<ValidationResult> results) {
    for (final result in results) {
      if (!result.isValid) {
        return result;
      }
    }
    return ValidationResult.valid();
  }
}

// Validation Result class
class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult._(this.isValid, this.errorMessage);

  factory ValidationResult.valid() {
    return const ValidationResult._(true, null);
  }

  factory ValidationResult.invalid(String errorMessage) {
    return ValidationResult._(false, errorMessage);
  }

  // Helper to get error message or empty string
  String get error => errorMessage ?? '';
}