
class AuthRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String emailVerification = '/email-verification';

  // Route parameters
  static const String paramToken = 'token';
  static const String paramEmail = 'email';

  // Route with parameters
  static String resetPasswordWithToken(String token) {
    return '$resetPassword?$paramToken=$token';
  }

  static String emailVerificationWithEmail(String email) {
    return '$emailVerification?$paramEmail=$email';
  }
}