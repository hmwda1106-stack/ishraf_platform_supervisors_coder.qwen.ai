/// ثوابت إعدادات API لتطبيق المشرف
/// 
/// المصدر: Public-Doc/docs/frontend-execution/shared/COMMON_FRONTEND_RULES.md
class ApiConstants {
  // Base URLs - Staging Environment
  static const String publicRootUrl =
      'https://ishraf-platform-backend-staging.onrender.com';
  static const String baseUrl =
      'https://ishraf-platform-backend-staging.onrender.com/api/v1';

  // Health endpoints (خارج api/v1)
  static const String healthEndpoint = '/health';
  static const String healthReadyEndpoint = '/health/ready';

  // API Version
  static const String apiVersion = 'v1';

  // Timeout settings (milliseconds)
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Pagination defaults
  static const int defaultPage = 1;
  static const int defaultLimit = 20;
  static const int maxLimit = 100;

  // Rate limiting retry
  static const int maxRetryAttempts = 1;
  static const int rateLimitRetryDelayMs = 2000;

  // Token refresh
  static const String tokenRefreshEndpoint = '/auth/refresh';
}
