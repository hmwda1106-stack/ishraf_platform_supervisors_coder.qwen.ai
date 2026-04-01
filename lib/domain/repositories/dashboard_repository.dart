import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/notification.dart';
import '../entities/pagination_model.dart';

/// واجهة مستودع لوحة التحكم
/// تحدد العمليات المتعلقة بإحصائيات لوحة التحكم والإشعارات
abstract class DashboardRepository {
  /// الحصول على إحصائيات لوحة التحكم
  /// يعيد [DashboardStats]
  Future<Either<Failure, DashboardStats>> getDashboardStats();

  /// الحصول على إشعارات المستخدم مع الترحيل
  /// [isRead] حالة القراءة (اختياري)
  /// [page] رقم الصفحة
  /// [limit] عدد العناصر في الصفحة
  /// يعيد [PaginationModel<Notification>]
  Future<Either<Failure, PaginationModel<Notification>>> getNotifications({
    bool? isRead,
    int page = 1,
    int limit = 20,
  });

  /// الحصول على عدد الإشعارات غير المقروءة
  /// يعيد العدد
  Future<Either<Failure, int>> getUnreadNotificationsCount();

  /// تحديث حالة قراءة إشعار
  /// [notificationId] معرف الإشعار
  Future<Either<Failure, void>> markNotificationAsRead({
    required String notificationId,
  });

  /// تحديث حالة قراءة جميع الإشعارات
  Future<Either<Failure, void>> markAllNotificationsAsRead();

  /// حذف إشعار
  /// [notificationId] معرف الإشعار
  Future<Either<Failure, void>> deleteNotification({
    required String notificationId,
  });

  /// حذف جميع الإشعارات
  Future<Either<Failure, void>> deleteAllNotifications();

  /// الحصول على آخر النشاطات
  /// [limit] عدد النشاطات
  /// يعيد قائمة [ActivityLog]
  Future<Either<Failure, List<ActivityLog>>> getRecentActivities({
    int limit = 10,
  });

  /// الحصول على إحصائيات سريعة
  /// يعيد [QuickStats]
  Future<Either<Failure, QuickStats>> getQuickStats();
}

/// سجل النشاطات
class ActivityLog {
  final String id;
  final String userId;
  final String userName;
  final String action;
  final String description;
  final DateTime timestamp;
  final String? entityType;
  final String? entityId;

  ActivityLog({
    required this.id,
    required this.userId,
    required this.userName,
    required this.action,
    required this.description,
    required this.timestamp,
    this.entityType,
    this.entityId,
  });
}

/// إحصائيات سريعة
class QuickStats {
  final int todayAttendanceRate;
  final int totalStudents;
  final int presentStudents;
  final int newBehaviorRecords;
  final int unreadMessages;
  final int pendingIssues;

  QuickStats({
    required this.todayAttendanceRate,
    required this.totalStudents,
    required this.presentStudents,
    required this.newBehaviorRecords,
    required this.unreadMessages,
    required this.pendingIssues,
  });
}
