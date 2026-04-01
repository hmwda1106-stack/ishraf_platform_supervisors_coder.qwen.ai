import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/attendance_session.dart';
import '../entities/pagination_model.dart';

/// واجهة مستودع الحضور
/// تحدد العمليات المتعلقة بجلسات الحضور وسجلات الطلاب
abstract class AttendanceRepository {
  /// الحصول على جلسات الحضور مع الترحيل
  /// [date] التاريخ (اختياري، الافتراضي اليوم)
  /// [page] رقم الصفحة
  /// [limit] عدد العناصر في الصفحة
  /// يعيد [PaginationModel<AttendanceSession>]
  Future<Either<Failure, PaginationModel<AttendanceSession>>> getAttendanceSessions({
    DateTime? date,
    int page = 1,
    int limit = 20,
  });

  /// الحصول على جلسة حضور محددة
  /// [sessionId] معرف الجلسة
  /// يعيد [AttendanceSession]
  Future<Either<Failure, AttendanceSession>> getAttendanceSession({
    required String sessionId,
  });

  /// إنشاء جلسة حضور جديدة
  /// [date] تاريخ الجلسة
  /// [shiftType] نوع الوردة (صباحي/مسائي)
  /// يعيد [AttendanceSession] المنشأة
  Future<Either<Failure, AttendanceSession>> createAttendanceSession({
    required DateTime date,
    required ShiftType shiftType,
  });

  /// بدء جلسة الحضور (فتح للطلاب)
  /// [sessionId] معرف الجلسة
  Future<Either<Failure, void>> startAttendanceSession({
    required String sessionId,
  });

  /// إنهاء جلسة الحضور (إغلاق للطلاب)
  /// [sessionId] معرف الجلسة
  Future<Either<Failure, void>> endAttendanceSession({
    required String sessionId,
  });

  /// تسجيل حضور طالب
  /// [sessionId] معرف الجلسة
  /// [studentId] معرف الطالب
  /// [arrivalTime] وقت الوصول (اختياري، الافتراضي الآن)
  /// يعيد [AttendanceRecord]
  Future<Either<Failure, AttendanceRecord>> markStudentAttendance({
    required String sessionId,
    required String studentId,
    DateTime? arrivalTime,
  });

  /// تحديث حالة حضور طالب
  /// [recordId] معرف السجل
  /// [status] الحالة الجديدة
  /// [notes] ملاحظات (اختياري)
  /// يعيد [AttendanceRecord] المحدث
  Future<Either<Failure, AttendanceRecord>> updateAttendanceRecord({
    required String recordId,
    required AttendanceStatus status,
    String? notes,
  });

  /// الحصول على سجلات الحضور لجلسة محددة
  /// [sessionId] معرف الجلسة
  /// يعيد قائمة [AttendanceRecord]
  Future<Either<Failure, List<AttendanceRecord>>> getAttendanceRecords({
    required String sessionId,
  });

  /// الحصول على سجل حضور محدد
  /// [recordId] معرف السجل
  /// يعيد [AttendanceRecord]
  Future<Either<Failure, AttendanceRecord>> getAttendanceRecord({
    required String recordId,
  });

  /// الحصول على إحصائيات الحضور لجلسة محددة
  /// [sessionId] معرف الجلسة
  /// يعيد [AttendanceStats]
  Future<Either<Failure, AttendanceStats>> getAttendanceStats({
    required String sessionId,
  });

  /// الحصول على ملخص الحضور لتاريخ محدد
  /// [date] التاريخ
  /// يعيد [DailyAttendanceSummary]
  Future<Either<Failure, DailyAttendanceSummary>> getDailyAttendanceSummary({
    required DateTime date,
  });
}

/// إحصائيات الحضور لجلسة
class AttendanceStats {
  final String sessionId;
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;
  final double attendanceRate;

  AttendanceStats({
    required this.sessionId,
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
    required this.attendanceRate,
  });
}

/// ملخص الحضور اليومي
class DailyAttendanceSummary {
  final DateTime date;
  final int totalSessions;
  final int totalStudents;
  final int totalPresent;
  final int totalAbsent;
  final double overallAttendanceRate;
  final List<SessionSummary> sessions;

  DailyAttendanceSummary({
    required this.date,
    required this.totalSessions,
    required this.totalStudents,
    required this.totalPresent,
    required this.totalAbsent,
    required this.overallAttendanceRate,
    required this.sessions,
  });
}

/// ملخص جلسة
class SessionSummary {
  final String sessionId;
  final ShiftType shiftType;
  final int studentCount;
  final int presentCount;
  final double attendanceRate;

  SessionSummary({
    required this.sessionId,
    required this.shiftType,
    required this.studentCount,
    required this.presentCount,
    required this.attendanceRate,
  });
}
