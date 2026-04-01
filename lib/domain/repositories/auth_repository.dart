import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/token_model.dart';
import '../entities/user.dart';

/// واجهة مستودع المصادقة
/// تحدد العمليات المتعلقة بتسجيل الدخول، تسجيل الخروج، وإدارة الجلسات
abstract class AuthRepository {
  /// تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
  /// [email] البريد الإلكتروني للمستخدم
  /// [password] كلمة المرور
  /// يعيد [User] و [TokenModel] عند النجاح
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  });

  /// تسجيل الخروج
  /// يحذف الرموز المحلية وينهي الجلسة
  Future<Either<Failure, void>> logout();

  /// التحقق من صحة الرمز المحدث وتحديثه إذا لزم الأمر
  /// يعيد [TokenModel] الجديد عند النجاح
  Future<Either<Failure, TokenModel>> refreshToken();

  /// الحصول على بيانات المستخدم الحالي
  /// يعيد [User] للمستخدم المسجل دخوله
  Future<Either<Failure, User>> getCurrentUser();

  /// التحقق مما إذا كان المستخدم مسجلاً للدخول
  /// يعيد [true] إذا كان هناك رمز صالح
  Future<bool> isLoggedIn();

  /// الحصول على الرمز المميز الحالي
  /// يعيد [String] أو [null] إذا لم يكن هناك رمز
  Future<String?> getToken();
}

/// نتيجة عملية المصادقة
/// تحتوي على بيانات المستخدم والرموز
class AuthResult {
  final User user;
  final TokenModel token;

  AuthResult({
    required this.user,
    required this.token,
  });
}
