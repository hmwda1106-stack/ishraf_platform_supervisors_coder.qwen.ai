/// ثوابت مسارات API لتطبيق المشرف
/// 
/// المصدر: Public-Doc/docs/frontend-execution/supervisor-app/ENDPOINT_MAP.md
class ApiEndpoints {
  // ==================== AUTH ====================
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String changePassword = '/auth/change-password';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // ==================== REPORTING (Dashboard) ====================
  static const String supervisorDashboard = '/reporting/dashboards/supervisor/me';
  static String studentProfile(String studentId) =>
      '/reporting/students/$studentId/profile';
  static String studentAttendanceSummary(String studentId) =>
      '/reporting/students/$studentId/reports/attendance-summary';
  static String studentAssessmentSummary(String studentId) =>
      '/reporting/students/$studentId/reports/assessment-summary';
  static String studentBehaviorSummary(String studentId) =>
      '/reporting/students/$studentId/reports/behavior-summary';

  // ==================== BEHAVIOR ====================
  static const String behaviorCategories = '/behavior/categories';
  static const String behaviorRecords = '/behavior/records';
  static String behaviorRecordDetail(String id) => '/behavior/records/$id';
  static String studentBehaviorTimeline(String studentId) =>
      '/behavior/students/$studentId/records';

  // ==================== ATTENDANCE ====================
  static const String attendanceSessions = '/attendance/sessions';
  static String attendanceSessionDetail(String id) =>
      '/attendance/sessions/$id';
  static String attendanceRecordUpdate(String attendanceId) =>
      '/attendance/records/$attendanceId';

  // ==================== COMMUNICATION ====================
  static const String communicationRecipients = '/communication/recipients';
  static const String communicationMessages = '/communication/messages';
  static const String communicationInbox = '/communication/messages/inbox';
  static const String communicationSent = '/communication/messages/sent';
  static String communicationConversation(String otherUserId) =>
      '/communication/messages/conversations/$otherUserId';
  static String communicationMessageRead(String messageId) =>
      '/communication/messages/$messageId/read';
  static const String communicationNotifications =
      '/communication/notifications/me';
  static String communicationNotificationRead(String notificationId) =>
      '/communication/notifications/$notificationId/read';
  static const String communicationAnnouncementsActive =
      '/communication/announcements/active';
}
