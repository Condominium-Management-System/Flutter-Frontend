
class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://backend-a3xi.onrender.com/api',
  );
  
  // Auth Endpoints
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authRefreshToken = '/auth/refresh-token';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authResetPassword = '/auth/reset-password';
  static const String authLogout = '/auth/logout';
  static const String authMe = '/auth/me';

  // Resident & Feature Endpoints
  static const String announcements = '/announcements';
  static const String payments = '/payments/';
  static const String transactions = '/transactions/my';
  static const String reports = '/reports';
  static const String users = '/users';
  static const String equb = '/equbs';
  static const String iddir = '/iddirs';
  static const String lostFound = '/lost-found';
  static const String chat = '/chat';
  static const String notifications = '/notifications';
  static const String dashboard = '/dashboard';
  
  // Headers
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String multipartFormData = 'multipart/form-data';
  static const String accept = 'Accept';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}