import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/message.dart';
import '../entities/pagination_model.dart';

/// واجهة مستودع التواصل
/// تحدد العمليات المتعلقة بالمراسلة والمحادثات
abstract class CommunicationRepository {
  /// الحصول على محادثات المستخدم مع الترحيل
  /// [page] رقم الصفحة
  /// [limit] عدد العناصر في الصفحة
  /// يعيد [PaginationModel<Conversation>]
  Future<Either<Failure, PaginationModel<Conversation>>> getConversations({
    int page = 1,
    int limit = 20,
  });

  /// الحصول على محادثة محددة
  /// [conversationId] معرف المحادثة
  /// يعيد [Conversation]
  Future<Either<Failure, Conversation>> getConversation({
    required String conversationId,
  });

  /// الحصول على رسائل محادثة معينة مع الترحيل
  /// [conversationId] معرف المحادثة
  /// [page] رقم الصفحة
  /// [limit] عدد العناصر في الصفحة
  /// يعيد [PaginationModel<Message>]
  Future<Either<Failure, PaginationModel<Message>>> getMessages({
    required String conversationId,
    int page = 1,
    int limit = 50,
  });

  /// إرسال رسالة جديدة
  /// [conversationId] معرف المحادثة (اختياري للمحادثات الجديدة)
  /// [recipientId] معرف المستقبل (للمحادثات الجديدة)
  /// [content] محتوى الرسالة
  /// [messageType] نوع الرسالة (نص/صورة/ملف)
  /// يعيد [Message] المرسلة
  Future<Either<Failure, Message>> sendMessage({
    String? conversationId,
    String? recipientId,
    required String content,
    MessageType messageType = MessageType.text,
  });

  /// تحديث حالة قراءة الرسالة
  /// [messageId] معرف الرسالة
  Future<Either<Failure, void>> markMessageAsRead({
    required String messageId,
  });

  /// تحديث حالة قراءة جميع رسائل محادثة
  /// [conversationId] معرف المحادثة
  Future<Either<Failure, void>> markConversationAsRead({
    required String conversationId,
  });

  /// حذف رسالة
  /// [messageId] معرف الرسالة
  Future<Either<Failure, void>> deleteMessage({
    required String messageId,
  });

  /// حذف محادثة
  /// [conversationId] معرف المحادثة
  Future<Either<Failure, void>> deleteConversation({
    required String conversationId,
  });

  /// البحث في الرسائل
  /// [query] نص البحث
  /// [conversationId] معرف المحادثة (اختياري)
  /// [page] رقم الصفحة
  /// [limit] عدد العناصر في الصفحة
  /// يعيد [PaginationModel<Message>]
  Future<Either<Failure, PaginationModel<Message>>> searchMessages({
    required String query,
    String? conversationId,
    int page = 1,
    int limit = 20,
  });

  /// إرسال إشعار Push
  /// [userId] معرف المستخدم
  /// [title] عنوان الإشعار
  /// [body] محتوى الإشعار
  /// [data] بيانات إضافية
  Future<Either<Failure, void>> sendPushNotification({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  });

  /// إرسال رسالة جماعية
  /// [recipientIds] قائمة معرفات المستقبلين
  /// [content] محتوى الرسالة
  /// [messageType] نوع الرسالة
  /// يعيد عدد الرسائل المرسلة بنجاح
  Future<Either<Failure, int>> sendBulkMessage({
    required List<String> recipientIds,
    required String content,
    MessageType messageType = MessageType.text,
  });
}
