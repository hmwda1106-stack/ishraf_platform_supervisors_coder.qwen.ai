part of 'pagination_model.dart';

PaginationModel<T> _$PaginationModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) =>
    PaginationModel<T>(
      currentPage: json['current_page'] as int,
      totalPages: json['total_pages'] as int,
      pageSize: json['page_size'] as int,
      totalItems: json['total_items'] as int,
      hasPrevious: json['has_previous'] as bool,
      hasNext: json['has_next'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((item) => fromJsonT(item))
          .toList(),
    );

Map<String, dynamic> _$PaginationModelToJson<T>(
  PaginationModel<T> instance,
  Object Function(T) toJsonT,
) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
      'page_size': instance.pageSize,
      'total_items': instance.totalItems,
      'has_previous': instance.hasPrevious,
      'has_next': instance.hasNext,
      'items': instance.items.map((item) => toJsonT(item)).toList(),
    };

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) =>
    PaginatedResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PaginationModel<T>.fromJson(json['data'] as Map<String, dynamic>, fromJsonT),
    );

Map<String, dynamic> _$PaginatedResponseToJson<T>(
  PaginatedResponse<T> instance,
  Object Function(T) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.toJson(toJsonT),
    };
