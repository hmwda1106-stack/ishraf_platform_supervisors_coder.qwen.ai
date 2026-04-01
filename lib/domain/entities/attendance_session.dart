import 'package:equatable/equatable.dart';

enum AttendanceType {
  morning,
  afternoon,
  fullDay,
}

enum AttendanceStatus {
  present,
  absent,
  late,
  excused,
  unknown,
}

class AttendanceSession extends Equatable {
  final String id;
  final DateTime date;
  final AttendanceType type;
  final String? sessionId;
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isClosed;
  final String? closedBy;
  final DateTime? closedAt;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AttendanceSession({
    required this.id,
    required this.date,
    required this.type,
    this.sessionId,
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
    required this.startTime,
    this.endTime,
    required this.isClosed,
    this.closedBy,
    this.closedAt,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  double get attendanceRate {
    if (totalStudents == 0) return 0.0;
    return presentCount / totalStudents;
  }

  String get attendanceRatePercent => '${(attendanceRate * 100).toStringAsFixed(1)}%';

  @override
  List<Object?> get props => [
        id,
        date,
        type,
        sessionId,
        totalStudents,
        presentCount,
        absentCount,
        lateCount,
        excusedCount,
        startTime,
        endTime,
        isClosed,
        closedBy,
        closedAt,
        notes,
        createdAt,
        updatedAt,
      ];

  AttendanceSession copyWith({
    String? id,
    DateTime? date,
    AttendanceType? type,
    String? sessionId,
    int? totalStudents,
    int? presentCount,
    int? absentCount,
    int? lateCount,
    int? excusedCount,
    DateTime? startTime,
    DateTime? endTime,
    bool? isClosed,
    String? closedBy,
    DateTime? closedAt,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceSession(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      sessionId: sessionId ?? this.sessionId,
      totalStudents: totalStudents ?? this.totalStudents,
      presentCount: presentCount ?? this.presentCount,
      absentCount: absentCount ?? this.absentCount,
      lateCount: lateCount ?? this.lateCount,
      excusedCount: excusedCount ?? this.excusedCount,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isClosed: isClosed ?? this.isClosed,
      closedBy: closedBy ?? this.closedBy,
      closedAt: closedAt ?? this.closedAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AttendanceRecord extends Equatable {
  final String id;
  final String sessionId;
  final String studentId;
  final String? studentName;
  final String? className;
  final AttendanceStatus status;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final String? markedBy;
  final String? markerName;
  final String? markerRole;
  final String? notes;
  final bool isEdited;
  final String? editedBy;
  final DateTime? editedAt;
  final String? editReason;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AttendanceRecord({
    required this.id,
    required this.sessionId,
    required this.studentId,
    this.studentName,
    this.className,
    required this.status,
    required this.checkInTime,
    this.checkOutTime,
    this.markedBy,
    this.markerName,
    this.markerRole,
    this.notes,
    required this.isEdited,
    this.editedBy,
    this.editedAt,
    this.editReason,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isPresent => status == AttendanceStatus.present;
  bool get isAbsent => status == AttendanceStatus.absent;
  bool get isLate => status == AttendanceStatus.late;
  bool get isExcused => status == AttendanceStatus.excused;

  @override
  List<Object?> get props => [
        id,
        sessionId,
        studentId,
        studentName,
        className,
        status,
        checkInTime,
        checkOutTime,
        markedBy,
        markerName,
        markerRole,
        notes,
        isEdited,
        editedBy,
        editedAt,
        editReason,
        createdAt,
        updatedAt,
      ];

  AttendanceRecord copyWith({
    String? id,
    String? sessionId,
    String? studentId,
    String? studentName,
    String? className,
    AttendanceStatus? status,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    String? markedBy,
    String? markerName,
    String? markerRole,
    String? notes,
    bool? isEdited,
    String? editedBy,
    DateTime? editedAt,
    String? editReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceRecord(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      className: className ?? this.className,
      status: status ?? this.status,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      markedBy: markedBy ?? this.markedBy,
      markerName: markerName ?? this.markerName,
      markerRole: markerRole ?? this.markerRole,
      notes: notes ?? this.notes,
      isEdited: isEdited ?? this.isEdited,
      editedBy: editedBy ?? this.editedBy,
      editedAt: editedAt ?? this.editedAt,
      editReason: editReason ?? this.editReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
