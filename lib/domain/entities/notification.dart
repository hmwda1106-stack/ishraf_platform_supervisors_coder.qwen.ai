import 'package:equatable/equatable.dart';

enum NotificationType {
  info,
  warning,
  error,
  success,
  behavior,
  attendance,
  message,
  system,
}

enum NotificationPriority {
  low,
  normal,
  high,
  urgent,
}

class Notification extends Equatable {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationPriority priority;
  final String? imageUrl;
  final Map<String, dynamic>? actionData;
  final String? actionType;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;

  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.priority,
    this.imageUrl,
    this.actionData,
    this.actionType,
    required this.isRead,
    required this.createdAt,
    this.readAt,
  });

  bool get isInfo => type == NotificationType.info;
  bool get isWarning => type == NotificationType.warning;
  bool get isError => type == NotificationType.error;
  bool get isSuccess => type == NotificationType.success;
  bool get isBehavior => type == NotificationType.behavior;
  bool get isAttendance => type == NotificationType.attendance;
  bool get isMessage => type == NotificationType.message;
  bool get isSystem => type == NotificationType.system;
  bool get isUrgent => priority == NotificationPriority.urgent;
  bool get isHighPriority => priority == NotificationPriority.high;

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        type,
        priority,
        imageUrl,
        actionData,
        actionType,
        isRead,
        createdAt,
        readAt,
      ];

  Notification copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    NotificationPriority? priority,
    String? imageUrl,
    Map<String, dynamic>? actionData,
    String? actionType,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      imageUrl: imageUrl ?? this.imageUrl,
      actionData: actionData ?? this.actionData,
      actionType: actionType ?? this.actionType,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
    );
  }
}

class DashboardStats extends Equatable {
  final int totalStudents;
  final int presentToday;
  final int absentToday;
  final int lateToday;
  final int positiveBehaviorsToday;
  final int negativeBehaviorsToday;
  final int pendingBehaviors;
  final int unreadNotifications;
  final int unreadMessages;
  final double attendanceRate;
  final DateTime lastUpdated;

  const DashboardStats({
    required this.totalStudents,
    required this.presentToday,
    required this.absentToday,
    required this.lateToday,
    required this.positiveBehaviorsToday,
    required this.negativeBehaviorsToday,
    required this.pendingBehaviors,
    required this.unreadNotifications,
    required this.unreadMessages,
    required this.attendanceRate,
    required this.lastUpdated,
  });

  int get totalBehaviorsToday => positiveBehaviorsToday + negativeBehaviorsToday;

  @override
  List<Object?> get props => [
        totalStudents,
        presentToday,
        absentToday,
        lateToday,
        positiveBehaviorsToday,
        negativeBehaviorsToday,
        pendingBehaviors,
        unreadNotifications,
        unreadMessages,
        attendanceRate,
        lastUpdated,
      ];

  DashboardStats copyWith({
    int? totalStudents,
    int? presentToday,
    int? absentToday,
    int? lateToday,
    int? positiveBehaviorsToday,
    int? negativeBehaviorsToday,
    int? pendingBehaviors,
    int? unreadNotifications,
    int? unreadMessages,
    double? attendanceRate,
    DateTime? lastUpdated,
  }) {
    return DashboardStats(
      totalStudents: totalStudents ?? this.totalStudents,
      presentToday: presentToday ?? this.presentToday,
      absentToday: absentToday ?? this.absentToday,
      lateToday: lateToday ?? this.lateToday,
      positiveBehaviorsToday: positiveBehaviorsToday ?? this.positiveBehaviorsToday,
      negativeBehaviorsToday: negativeBehaviorsToday ?? this.negativeBehaviorsToday,
      pendingBehaviors: pendingBehaviors ?? this.pendingBehaviors,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
