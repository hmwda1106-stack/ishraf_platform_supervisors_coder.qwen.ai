import 'package:equatable/equatable.dart';

enum BehaviorType {
  positive,
  negative,
}

enum BehaviorCategoryType {
  attendance,
  discipline,
  academic,
  social,
  health,
  transportation,
  other,
}

class BehaviorCategory extends Equatable {
  final String id;
  final String name;
  final String? nameAr;
  final String? nameEn;
  final BehaviorCategoryType type;
  final String? description;
  final int sortOrder;
  final bool isActive;

  const BehaviorCategory({
    required this.id,
    required this.name,
    this.nameAr,
    this.nameEn,
    required this.type,
    this.description,
    required this.sortOrder,
    required this.isActive,
  });

  String get displayName => nameAr ?? nameEn ?? name;

  @override
  List<Object?> get props => [
        id,
        name,
        nameAr,
        nameEn,
        type,
        description,
        sortOrder,
        isActive,
      ];

  BehaviorCategory copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? nameEn,
    BehaviorCategoryType? type,
    String? description,
    int? sortOrder,
    bool? isActive,
  }) {
    return BehaviorCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      type: type ?? this.type,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
    );
  }
}

class BehaviorRecord extends Equatable {
  final String id;
  final String studentId;
  final String? studentName;
  final BehaviorType type;
  final String categoryId;
  final BehaviorCategory? category;
  final String title;
  final String? description;
  final int? points;
  final String? reportedBy;
  final String? reporterName;
  final String? reporterRole;
  final DateTime recordedAt;
  final String? notes;
  final List<String>? attachments;
  final bool isViewed;
  final bool isResolved;
  final String? resolvedBy;
  final DateTime? resolvedAt;
  final String? resolutionNotes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BehaviorRecord({
    required this.id,
    required this.studentId,
    this.studentName,
    required this.type,
    required this.categoryId,
    this.category,
    required this.title,
    this.description,
    this.points,
    this.reportedBy,
    this.reporterName,
    this.reporterRole,
    required this.recordedAt,
    this.notes,
    this.attachments,
    required this.isViewed,
    required this.isResolved,
    this.resolvedBy,
    this.resolvedAt,
    this.resolutionNotes,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isPositive => type == BehaviorType.positive;
  bool get isNegative => type == BehaviorType.negative;
  bool get requiresAction => !isResolved && isNegative;

  @override
  List<Object?> get props => [
        id,
        studentId,
        studentName,
        type,
        categoryId,
        category,
        title,
        description,
        points,
        reportedBy,
        reporterName,
        reporterRole,
        recordedAt,
        notes,
        attachments,
        isViewed,
        isResolved,
        resolvedBy,
        resolvedAt,
        resolutionNotes,
        createdAt,
        updatedAt,
      ];

  BehaviorRecord copyWith({
    String? id,
    String? studentId,
    String? studentName,
    BehaviorType? type,
    String? categoryId,
    BehaviorCategory? category,
    String? title,
    String? description,
    int? points,
    String? reportedBy,
    String? reporterName,
    String? reporterRole,
    DateTime? recordedAt,
    String? notes,
    List<String>? attachments,
    bool? isViewed,
    bool? isResolved,
    String? resolvedBy,
    DateTime? resolvedAt,
    String? resolutionNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BehaviorRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      points: points ?? this.points,
      reportedBy: reportedBy ?? this.reportedBy,
      reporterName: reporterName ?? this.reporterName,
      reporterRole: reporterRole ?? this.reporterRole,
      recordedAt: recordedAt ?? this.recordedAt,
      notes: notes ?? this.notes,
      attachments: attachments ?? this.attachments,
      isViewed: isViewed ?? this.isViewed,
      isResolved: isResolved ?? this.isResolved,
      resolvedBy: resolvedBy ?? this.resolvedBy,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      resolutionNotes: resolutionNotes ?? this.resolutionNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
