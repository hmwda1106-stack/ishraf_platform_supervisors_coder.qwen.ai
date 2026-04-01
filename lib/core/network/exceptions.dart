/// استثناءات الشبكة لتطبيق المشرف
/// 
/// المصدر: Public-Doc/docs/frontend-execution/shared/COMMON_FRONTEND_RULES.md
abstract class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  NetworkException({
    required this.message,
    this.statusCode,
    this.originalError,
  });
}

/// خطأ في الخادم (5xx)
class ServerException extends NetworkException {
  ServerException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// خطأ في الاتصال (Network unreachable)
class ConnectionException extends NetworkException {
  ConnectionException({
    required super.message,
    super.originalError,
  });
}

/// خطأ في المصادقة (401)
class UnauthorizedException extends NetworkException {
  UnauthorizedException({
    required super.message,
    super.statusCode = 401,
    super.originalError,
  });
}

/// خطأ في الصلاحيات (403)
class ForbiddenException extends NetworkException {
  ForbiddenException({
    required super.message,
    super.statusCode = 403,
    super.originalError,
  });
}

/// المورد غير موجود (404)
class NotFoundException extends NetworkException {
  NotFoundException({
    required super.message,
    super.statusCode = 404,
    super.originalError,
  });
}

/// خطأ في التحقق من صحة البيانات (400/422)
class ValidationException extends NetworkException {
  final List<ValidationError>? errors;

  ValidationException({
    required super.message,
    super.statusCode,
    super.originalError,
    this.errors,
  });
}

class ValidationError {
  final String? field;
  final String? code;
  final String message;

  ValidationError({
    this.field,
    this.code,
    required this.message,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      field: json['field'] as String?,
      code: json['code'] as String?,
      message: json['message'] as String? ?? 'Validation error',
    );
  }
}

/// تجاوز حد المعدل (429)
class RateLimitException extends NetworkException {
  RateLimitException({
    required super.message,
    super.statusCode = 429,
    super.originalError,
  });
}

/// خطأ عام غير معروف
class UnknownException extends NetworkException {
  UnknownException({
    required super.message,
    super.originalError,
  });
}
