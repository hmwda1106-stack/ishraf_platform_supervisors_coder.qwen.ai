/// عميل HTTP للتواصل مع API باستخدام Dio
/// 
/// المصدر: Public-Doc/docs/frontend-execution/shared/COMMON_FRONTEND_RULES.md
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../constants/api_endpoints.dart';
import 'exceptions.dart';

/// معلومات الشبكة للتحقق من الاتصال
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final ConnectivityPlus connectivityPlus;

  NetworkInfoImpl({required this.connectivityPlus});

  @override
  Future<bool> get isConnected async {
    try {
      final connectivityResult = await connectivityPlus.checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }
}

/// العميل الأساسي لـ Dio مع إعدادات المصادقة والمعالجة
class ApiClient {
  late final Dio _dio;
  String? _accessToken;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectionTimeout),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
      sendTimeout: Duration(milliseconds: ApiConstants.sendTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // إضافة interceptor للمصادقة ومعالجة الأخطاء
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_accessToken != null) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        final exception = _handleDioError(error);
        return handler.reject(DioException(
          requestOptions: error.requestOptions,
          response: error.response,
          error: exception,
          type: error.type,
        ));
      },
    ));
  }

  /// تعيين رمز الوصول للاستخدام في الطلبات المحمية
  void setAccessToken(String? token) {
    _accessToken = token;
  }

  /// معالجة أخطاء Dio وتحويلها لاستثناءات مخصصة
  NetworkException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ConnectionException(
          message: 'انتهت مهلة الاتصال. يرجى التحقق من اتصالك بالإنترنت.',
          originalError: error,
        );

      case DioExceptionType.connectionError:
        return ConnectionException(
          message: 'لا يمكن الاتصال بالخادم. يرجى التحقق من اتصالك بالإنترنت.',
          originalError: error,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        switch (statusCode) {
          case 401:
            return UnauthorizedException(
              message: 'جلسة غير صالحة. يرجى تسجيل الدخول مرة أخرى.',
              statusCode: statusCode,
              originalError: error,
            );

          case 403:
            return ForbiddenException(
              message: _extractErrorMessage(data) ??
                  'ليس لديك صلاحية للوصول إلى هذا المورد.',
              statusCode: statusCode,
              originalError: error,
            );

          case 404:
            return NotFoundException(
              message: _extractErrorMessage(data) ?? 'المورد المطلوب غير موجود.',
              statusCode: statusCode,
              originalError: error,
            );

          case 400:
          case 422:
            return ValidationException(
              message: _extractErrorMessage(data) ?? 'خطأ في البيانات المدخلة.',
              statusCode: statusCode,
              originalError: error,
              errors: _extractValidationErrors(data),
            );

          case 429:
            return RateLimitException(
              message: 'تم تجاوز عدد المحاولات المسموح بها. يرجى المحاولة لاحقاً.',
              statusCode: statusCode,
              originalError: error,
            );

          default:
            if (statusCode != null && statusCode >= 500) {
              return ServerException(
                message: 'خطأ في الخادم. يرجى المحاولة لاحقاً.',
                statusCode: statusCode,
                originalError: error,
              );
            }
            return UnknownException(
              message: _extractErrorMessage(data) ?? 'حدث خطأ غير متوقع.',
              originalError: error,
            );
        }

      case DioExceptionType.cancel:
        return UnknownException(
          message: 'تم إلغاء الطلب.',
          originalError: error,
        );

      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
      default:
        return UnknownException(
          message: 'حدث خطأ غير متوقع.',
          originalError: error,
        );
    }
  }

  /// استخراج رسالة الخطأ من استجابة API
  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String?;
    } else if (data is String) {
      return data;
    }
    return null;
  }

  /// استخراج أخطاء التحقق من الصحة
  List<ValidationError>? _extractValidationErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      final errorsJson = data['errors'] as List<dynamic>?;
      if (errorsJson != null) {
        return errorsJson
            .map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return null;
  }

  // ==================== GET ====================
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        rethrow;
      }
      throw UnknownException(
        message: 'حدث خطأ أثناء جلب البيانات.',
        originalError: e,
      );
    }
  }

  // ==================== POST ====================
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        rethrow;
      }
      throw UnknownException(
        message: 'حدث خطأ أثناء إرسال البيانات.',
        originalError: e,
      );
    }
  }

  // ==================== PATCH ====================
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        rethrow;
      }
      throw UnknownException(
        message: 'حدث خطأ أثناء تحديث البيانات.',
        originalError: e,
      );
    }
  }

  // ==================== DELETE ====================
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        rethrow;
      }
      throw UnknownException(
        message: 'حدث خطأ أثناء الحذف.',
        originalError: e,
      );
    }
  }
}
