class StorageKeys {
  // Auth Tokens
  static const String accessToken = 'auth_access_token';
  static const String refreshToken = 'auth_refresh_token';
  static const String tokenExpiry = 'auth_token_expiry';
  
  // User Data
  static const String userData = 'auth_user_data';
  static const String userId = 'auth_user_id';
  static const String userRole = 'auth_user_role';
  static const String condoId = 'auth_condo_id';
  static const String isVerified = 'auth_is_verified';
  
  // Preferences
  static const String rememberMe = 'auth_remember_me';
  static const String savedEmail = 'auth_saved_email';
  static const String savedPassword = 'auth_saved_password';
  static const String isLoggedIn = 'auth_is_logged_in';
  static const String firstLaunch = 'auth_first_launch';
  
  // Theme
  static const String themeMode = 'auth_theme_mode';
  
  // Notifications
  static const String notificationsEnabled = 'auth_notifications_enabled';
  static const String fcmToken = 'auth_fcm_token';
}
