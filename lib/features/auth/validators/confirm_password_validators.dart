
import '../../../core/utils/validators.dart';

class ConfirmPasswordValidator {
  static String? validate(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    
    if (value != password) {
      return 'Passwords do not match.';
    }
    
    return null;
  }

  static bool doMatch(String? value, String password) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return Validators.doPasswordsMatch(password, value);
  }
}