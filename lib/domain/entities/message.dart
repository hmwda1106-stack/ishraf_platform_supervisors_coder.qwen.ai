import 'package:equatable/equatable.dart';

enum MessageType {
  text,
  image,
  file,
  voice,
}

enum MessageStatus {
  sent,
  delivered,
  read,
  failed,
}

class Message extends Equatable {
  final String id;
  final String conversationId;
  final String senderId;
  final String? senderName;
  final String? senderRole;
  final String receiverId;
  final String? receiverName;
  final String? receiverRole;
  final MessageType type;
  final String content;
  final List<String>? attachments;
  final MessageStatus status;
  final DateTime sentAt;
  final DateTime? deliveredAt;
  final DateTime? readAt;
  final bool isDeleted;
  final DateTime? deletedAt;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    this.senderName,
    this.senderRole,
    required this.receiverId,
    this.receiverName,
    this.receiverRole,
    required this.type,
    required this.content,
    this.attachments,
    required this.status,
    required this.sentAt,
    this.deliveredAt,
    this.readAt,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
  });

  bool get isText => type == MessageType.text;
  bool get isImage => type == MessageType.image;
  bool get isFile => type == MessageType.file;
  bool get isVoice => type == MessageType.voice;
  bool get isSent => status == MessageStatus.sent;
  bool get isDelivered => status == MessageStatus.delivered;
  bool get isRead => status == MessageStatus.read;
  bool get isFailed => status == MessageStatus.failed;

  @override
  List<Object?> get props => [
        id,
        conversationId,
        senderId,
        senderName,
        senderRole,
        receiverId,
        receiverName,
        receiverRole,
        type,
        content,
        attachments,
        status,
        sentAt,
        deliveredAt,
        readAt,
        isDeleted,
        deletedAt,
        createdAt,
      ];

  Message copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? senderName,
    String? senderRole,
    String? receiverId,
    String? receiverName,
    String? receiverRole,
    MessageType? type,
    String? content,
    List<String>? attachments,
    MessageStatus? status,
    DateTime? sentAt,
    DateTime? deliveredAt,
    DateTime? readAt,
    bool? isDeleted,
    DateTime? deletedAt,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderRole: senderRole ?? this.senderRole,
      receiverId: receiverId ?? this.receiverId,
      receiverName: receiverName ?? this.receiverName,
      receiverRole: receiverRole ?? this.receiverRole,
      type: type ?? this.type,
      content: content ?? this.content,
      attachments: attachments ?? this.attachments,
      status: status ?? this.status,
      sentAt: sentAt ?? this.sentAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      readAt: readAt ?? this.readAt,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class Conversation extends Equatable {
  final String id;
  final String participant1Id;
  final String? participant1Name;
  final String? participant1Photo;
  final String participant2Id;
  final String? participant2Name;
  final String? participant2Photo;
  final String lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Conversation({
    required this.id,
    required this.participant1Id,
    this.participant1Name,
    this.participant1Photo,
    required this.participant2Id,
    this.participant2Name,
    this.participant2Photo,
    required this.lastMessage,
    this.lastMessageAt,
    required this.unreadCount,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  String get otherParticipantName => participant1Name ?? participant2Name ?? 'Unknown';
  String get otherParticipantPhoto => participant1Photo ?? participant2Photo ?? '';
  String get otherParticipantId => participant1Id == 'current_user' ? participant2Id : participant1Id;

  @override
  List<Object?> get props => [
        id,
        participant1Id,
        participant1Name,
        participant1Photo,
        participant2Id,
        participant2Name,
        participant2Photo,
        lastMessage,
        lastMessageAt,
        unreadCount,
        isActive,
        createdAt,
        updatedAt,
      ];

  Conversation copyWith({
    String? id,
    String? participant1Id,
    String? participant1Name,
    String? participant1Photo,
    String? participant2Id,
    String? participant2Name,
    String? participant2Photo,
    String? lastMessage,
    DateTime? lastMessageAt,
    int? unreadCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Conversation(
      id: id ?? this.id,
      participant1Id: participant1Id ?? this.participant1Id,
      participant1Name: participant1Name ?? this.participant1Name,
      participant1Photo: participant1Photo ?? this.participant1Photo,
      participant2Id: participant2Id ?? this.participant2Id,
      participant2Name: participant2Name ?? this.participant2Name,
      participant2Photo: participant2Photo ?? this.participant2Photo,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
