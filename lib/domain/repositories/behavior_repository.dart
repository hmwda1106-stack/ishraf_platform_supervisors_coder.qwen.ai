import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/behavior_record.dart';
import '../entities/student.dart';
import '../entities/pagination_model.dart';

/// واجهة مستودع السلوك
/// تحدد العمليات المتعلقة بسجلات السلوك والفئات
abstract class BehaviorRepository {
  /// الحصول على سجلات السلوك مع الترحيل
  /// [studentId] معرف الطالب (اختياري)
  /// [categoryId] معرف الفئة (اختياري)
  /// [page] رقم الصفحة
  /// [limit] عدد العناصر في الصفحة
  /// يعيد [PaginationModel<BehaviorRecord>]
  Future<Either<Failure, PaginationModel<BehaviorRecord>>> getBehaviorRecords({
    String? studentId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  });

  /// الحصول على سجل سلوك محدد
  /// [recordId] معرف السجل
  /// يعيد [BehaviorRecord]
  Future<Either<Failure, BehaviorRecord>> getBehaviorRecord({
    required String recordId,
  });

  /// إضافة سجل سلوك جديد
  /// [studentId] معرف الطالب
  /// [categoryId] معرف الفئة
  /// [description] وصف السلوك
  /// [points] النقاط (موجبة للإيجابي، سالبة للسلبي)
  /// يعيد [BehaviorRecord] المضاف
  Future<Either<Failure, BehaviorRecord>> addBehaviorRecord({
    required String studentId,
    required String categoryId,
    required String description,
    required double points,
  });

  /// تحديث سجل سلوك موجود
  /// [recordId] معرف السجل
  /// [description] وصف السلوك الجديد (اختياري)
  /// [points] النقاط الجديدة (اختياري)
  /// يعيد [BehaviorRecord] المحدث
  Future<Either<Failure, BehaviorRecord>> updateBehaviorRecord({
    required String recordId,
    String? description,
    double? points,
  });

  /// حذف سجل سلوك
  /// [recordId] معرف السجل
  Future<Either<Failure, void>> deleteBehaviorRecord({
    required String recordId,
  });

  /// الحصول على فئات السلوك
  /// يعيد قائمة [BehaviorCategory]
  Future<Either<Failure, List<BehaviorCategory>>> getBehaviorCategories();

  /// إضافة فئة سلوك جديدة
  /// [name] اسم الفئة
  /// [type] نوع الفئة (إيجابي/سلبي)
  /// [defaultPoints] النقاط الافتراضية
  /// يعيد [BehaviorCategory] المضافة
  Future<Either<Failure, BehaviorCategory>> addBehaviorCategory({
    required String name,
    required BehaviorCategoryType type,
    required double defaultPoints,
  });

  /// تحديث فئة سلوك موجودة
  /// [categoryId] معرف الفئة
  /// [name] اسم الفئة الجديد (اختياري)
  /// [defaultPoints] النقاط الافتراضية الجديدة (اختياري)
  /// يعيد [BehaviorCategory] المحدثة
  Future<Either<Failure, BehaviorCategory>> updateBehaviorCategory({
    required String categoryId,
    String? name,
    double? defaultPoints,
  });

  /// حذف فئة سلوك
  /// [categoryId] معرف الفئة
  Future<Either<Failure, void>> deleteBehaviorCategory({
    required String categoryId,
  });

  /// الحصول على إحصائيات السلوك لطالب محدد
  /// [studentId] معرف الطالب
  /// يعيد [BehaviorStats]
  Future<Either<Failure, BehaviorStats>> getBehaviorStats({
    required String studentId,
  });
}

/// إحصائيات السلوك لطالب
class BehaviorStats {
  final String studentId;
  final int totalRecords;
  final int positiveCount;
  final int negativeCount;
  final double totalPoints;
  final double averagePoints;
  final DateTime? lastRecordDate;

  BehaviorStats({
    required this.studentId,
    required this.totalRecords,
    required this.positiveCount,
    required this.negativeCount,
    required this.totalPoints,
    required this.averagePoints,
    required this.lastRecordDate,
  });
}
