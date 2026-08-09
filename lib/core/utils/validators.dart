
class Validators {
  // Email validation
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    return emailRegex.hasMatch(email);
  }
  
  // Phone validation (Ethiopian format)
  static bool isValidPhone(String phone) {
    if (phone.isEmpty) return false;
    final phoneRegex = RegExp(
      r'^(\+251|0)?[9][0-9]{8}$',
    );
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'\s'), ''));
  }
  
  // Password validation
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }
  
  // Password strength check
  static PasswordStrength getPasswordStrength(String password) {
    int score = 0;
    
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    
    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.medium;
    if (score <= 5) return PasswordStrength.good;
    return PasswordStrength.strong;
  }
  
  // Name validation
  static bool isValidName(String name) {
    if (name.isEmpty) return false;
    if (name.length < 2) return false;
    if (name.length > 50) return false;
    return true;
  }
  
  // FAN validation
  static bool isValidFAN(String fan) {
    if (fan.isEmpty) return false;
    final fanRegex = RegExp(
      r'^[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}$',
    );
    return fanRegex.hasMatch(fan);
  }
  
  // Confirm password
  static bool doPasswordsMatch(String password, String confirm) {
    return password == confirm;
  }
}

enum PasswordStrength {
  weak,
  medium,
  good,
  strong,
}

extension PasswordStrengthExtension on PasswordStrength {
  String get label {
    switch (this) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.good:
        return 'Good';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }
}