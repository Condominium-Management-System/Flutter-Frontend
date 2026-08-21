class ResidentRoutes {
  // ROUTE NAMES
  static const String home = '/resident/home';
  static const String dashboard = '/resident/dashboard';

  // Payments
  static const String payments = '/resident/payments';
  static const String makePayment = '/resident/payments/make';
  static const String paymentDetail = '/resident/payments/detail';
  static const String paymentHistory = '/resident/payments/history';
  static const String paymentReceipt = '/resident/payments/receipt';

  // Announcements
  static const String announcements = '/resident/announcements';
  static const String announcementDetail = '/resident/announcements/detail';

  // Reports
  static const String reports = '/resident/reports';
  static const String reportDetail = '/resident/reports/detail';
  static const String createReport = '/resident/reports/create';

  // Community - Equb
  static const String equbList = '/resident/equb';
  static const String equbDetail = '/resident/equb/detail';
  static const String equbJoin = '/resident/equb/join';
  static const String equbContribution = '/resident/equb/contribute';

  // Community - Iddir
  static const String iddirList = '/resident/iddir';
  static const String iddirDetail = '/resident/iddir/detail';
  static const String iddirJoin = '/resident/iddir/join';
  static const String iddirContribution = '/resident/iddir/contribute';

  // Lost & Found
  static const String lostFound = '/resident/lost-found';
  static const String lostFoundDetail = '/resident/lost-found/detail';
  static const String createLost = '/resident/lost-found/create-lost';
  static const String createFound = '/resident/lost-found/create-found';
  static const String claimItem = '/resident/lost-found/claim';
  static const String myItems = '/resident/lost-found/my-items';

  // Chat
  static const String chatList = '/resident/chat';
  static const String chatRoom = '/resident/chat/room';
  static const String chatAdmin = '/resident/chat/admin';
  static const String chatGuard = '/resident/chat/guard';

  // Notifications
  static const String notifications = '/resident/notifications';
  static const String notificationDetail = '/resident/notifications/detail';

  // Neighbors
  static const String neighbors = '/resident/neighbors';
  static const String neighborDetail = '/resident/neighbors/detail';

  // Profile
  static const String profile = '/resident/profile';
  static const String editProfile = '/resident/profile/edit';
  static const String changePassword = '/resident/profile/change-password';
  static const String notificationSettings = '/resident/profile/notifications';
  static const String appSettings = '/resident/profile/settings';
  static const String helpSupport = '/resident/profile/help';
  static const String termsPrivacy = '/resident/profile/terms';

  // ROUTE PARAMETERS
  static const String paramId = 'id';
  static const String paramEqubId = 'equbId';
  static const String paramIddirId = 'iddirId';
  static const String paramReportId = 'reportId';
  static const String paramPaymentId = 'paymentId';
  static const String paramAnnouncementId = 'announcementId';
  static const String paramLostFoundId = 'lostFoundId';
  static const String paramChatId = 'chatId';

  // ROUTE BUILDERS
  static String paymentDetailRoute(String id) => '$paymentDetail?$paramPaymentId=$id';
  static String reportDetailRoute(String id) => '$reportDetail?$paramReportId=$id';
  static String announcementDetailRoute(String id) => '$announcementDetail?$paramAnnouncementId=$id';
  static String equbDetailRoute(String id) => '$equbDetail?$paramEqubId=$id';
  static String iddirDetailRoute(String id) => '$iddirDetail?$paramIddirId=$id';
  static String lostFoundDetailRoute(String id) => '$lostFoundDetail?$paramLostFoundId=$id';
  static String chatRoomRoute(String id) => '$chatRoom?$paramChatId=$id';
}