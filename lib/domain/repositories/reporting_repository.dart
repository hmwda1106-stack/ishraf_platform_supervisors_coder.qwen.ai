import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';

/// واجهة مستودع التقارير
/// تحدد العمليات المتعلقة بالتقارير والتحليلات
abstract class ReportingRepository {
  /// توليد تقرير الحضور
  /// [startDate] تاريخ البداية
  /// [endDate] تاريخ النهاية
  /// [studentId] معرف الطالب (اختياري)
  /// [format] صيغة التقرير (PDF/Excel)
  /// يعيد URL التقرير
  Future<Either<Failure, String>> generateAttendanceReport({
    required DateTime startDate,
    required DateTime endDate,
    String? studentId,
    ReportFormat format = ReportFormat.pdf,
  });

  /// توليد تقرير السلوك
  /// [startDate] تاريخ البداية
  /// [endDate] تاريخ النهاية
  /// [studentId] معرف الطالب (اختياري)
  /// [categoryId] معرف الفئة (اختياري)
  /// [format] صيغة التقرير
  /// يعيد URL التقرير
  Future<Either<Failure, String>> generateBehaviorReport({
    required DateTime startDate,
    required DateTime endDate,
    String? studentId,
    String? categoryId,
    ReportFormat format = ReportFormat.pdf,
  });

  /// توليد تقرير شامل
  /// [startDate] تاريخ البداية
  /// [endDate] تاريخ النهاية
  /// [includeAttendance] تضمين الحضور
  /// [includeBehavior] تضمين السلوك
  /// [format] صيغة التقرير
  /// يعيد URL التقرير
  Future<Either<Failure, String>> generateComprehensiveReport({
    required DateTime startDate,
    required DateTime endDate,
    bool includeAttendance = true,
    bool includeBehavior = true,
    ReportFormat format = ReportFormat.pdf,
  });

  /// الحصول على بيانات الرسم البياني للحضور
  /// [startDate] تاريخ البداية
  /// [endDate] تاريخ النهاية
  /// [groupBy] التجميع (يوم/أسبوع/شهر)
  /// يعيد [ChartData]
  Future<Either<Failure, ChartData>> getAttendanceChartData({
    required DateTime startDate,
    required DateTime endDate,
    GroupBy groupBy = GroupBy.day,
  });

  /// الحصول على بيانات الرسم البياني للسلوك
  /// [startDate] تاريخ البداية
  /// [endDate] تاريخ النهاية
  /// [groupBy] التجميع
  /// يعيد [ChartData]
  Future<Either<Failure, ChartData>> getBehaviorChartData({
    required DateTime startDate,
    required DateTime endDate,
    GroupBy groupBy = GroupBy.day,
  });

  /// الحصول على إحصائيات مفصلة
  /// [startDate] تاريخ البداية
  /// [endDate] تاريخ النهاية
  /// يعيد [DetailedStats]
  Future<Either<Failure, DetailedStats>> getDetailedStats({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// تصدير البيانات
  /// [dataType] نوع البيانات
  /// [startDate] تاريخ البداية
  /// [endDate] تاريخ النهاية
  /// [format] صيغة التصدير
  /// يعيد URL الملف
  Future<Either<Failure, String>> exportData({
    required DataType dataType,
    required DateTime startDate,
    required DateTime endDate,
    ExportFormat format = ExportFormat.csv,
  });
}

/// صيغة التقرير
enum ReportFormat {
  pdf,
  excel,
  word,
}

/// صيغة التصدير
enum ExportFormat {
  csv,
  excel,
  json,
}

/// نوع البيانات
enum DataType {
  attendance,
  behavior,
  students,
  all,
}

/// التجميع
enum GroupBy {
  day,
  week,
  month,
  year,
}

/// بيانات الرسم البياني
class ChartData {
  final List<String> labels;
  final List<num> values;
  final List<String>? seriesNames;
  final Map<String, List<num>>? seriesData;

  ChartData({
    required this.labels,
    required this.values,
    this.seriesNames,
    this.seriesData,
  });
}

/// إحصائيات مفصلة
class DetailedStats {
  final DateTime startDate;
  final DateTime endDate;
  
  // Attendance Stats
  final int totalSessions;
  final double averageAttendanceRate;
  final int perfectAttendanceDays;
  
  // Behavior Stats
  final int totalBehaviorRecords;
  final int positiveBehaviors;
  final int negativeBehaviors;
  final double averagePoints;
  
  // Top Performers
  final List<TopStudent> topStudentsByAttendance;
  final List<TopStudent> topStudentsByBehavior;
  
  // Trends
  final String attendanceTrend; // 'increasing', 'decreasing', 'stable'
  final String behaviorTrend;

  DetailedStats({
    required this.startDate,
    required this.endDate,
    required this.totalSessions,
    required this.averageAttendanceRate,
    required this.perfectAttendanceDays,
    required this.totalBehaviorRecords,
    required this.positiveBehaviors,
    required this.negativeBehaviors,
    required this.averagePoints,
    required this.topStudentsByAttendance,
    required this.topStudentsByBehavior,
    required this.attendanceTrend,
    required this.behaviorTrend,
  });
}

/// طالب متميز
class TopStudent {
  final String studentId;
  final String studentName;
  final num score;
  final String reason;

  TopStudent({
    required this.studentId,
    required this.studentName,
    required this.score,
    required this.reason,
  });
}
