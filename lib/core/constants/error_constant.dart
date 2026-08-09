
class ErrorMessages {
  // Network Errors
  static const String networkError = 'Network error. Please check your internet connection.';
  static const String timeoutError = 'Connection timeout. Please try again.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'Something went wrong. Please try again.';
  
  // Auth Errors
  static const String invalidCredentials = 'Invalid email or password. Please try again.';
  static const String userNotFound = 'No account found with this email.';
  static const String emailAlreadyExists = 'An account with this email already exists.';
  static const String phoneAlreadyExists = 'An account with this phone number already exists.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String invalidPhone = 'Please enter a valid phone number.';
  static const String invalidPassword = 'Password must meet the requirements.';
  static const String passwordsDoNotMatch = 'Passwords do not match.';
  static const String weakPassword = 'Password is too weak. Please use a stronger password.';
  static const String invalidToken = 'Invalid or expired token.';
  static const String sessionExpired = 'Your session has expired. Please login again.';
  static const String unauthorized = 'Unauthorized access. Please login.';
  static const String forbidden = 'You do not have permission to perform this action.';
  static const String accountLocked = 'Your account has been locked. Please contact support.';
  static const String tooManyAttempts = 'Too many failed attempts. Please try again later.';
  
  // Registration Errors
  static const String registrationFailed = 'Registration failed. Please try again.';
  static const String invalidCondoCode = 'Invalid condominium code.';
  static const String condoNotFound = 'Condominium not found.';
  static const String fanAlreadyExists = 'FAN number already registered.';
  
  // Password Reset Errors
  static const String passwordResetFailed = 'Password reset failed. Please try again.';
  static const String invalidResetToken = 'Invalid or expired reset link.';
  static const String passwordResetLinkExpired = 'Reset link has expired. Please request a new one.';
  
  // Profile Errors
  static const String profileUpdateFailed = 'Failed to update profile. Please try again.';
  static const String fileUploadFailed = 'File upload failed. Please try again.';
  static const String invalidFileType = 'Invalid file type. Please upload a valid image.';
  static const String fileTooLarge = 'File is too large. Maximum size is 5MB.';
  
  // General Errors
  static const String requiredField = 'This field is required.';
  static const String invalidField = 'Please enter a valid value.';
}