import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationModel<T> extends Equatable {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalItems;
  final bool hasPrevious;
  final bool hasNext;
  final List<T> items;

  const PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalItems,
    required this.hasPrevious,
    required this.hasNext,
    required this.items,
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginationModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$PaginationModelToJson(this, toJsonT);

  @override
  List<Object?> get props => [
        currentPage,
        totalPages,
        pageSize,
        totalItems,
        hasPrevious,
        hasNext,
        items,
      ];

  PaginationModel<T> copyWith({
    int? currentPage,
    int? totalPages,
    int? pageSize,
    int? totalItems,
    bool? hasPrevious,
    bool? hasNext,
    List<T>? items,
  }) {
    return PaginationModel(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      pageSize: pageSize ?? this.pageSize,
      totalItems: totalItems ?? this.totalItems,
      hasPrevious: hasPrevious ?? this.hasPrevious,
      hasNext: hasNext ?? this.hasNext,
      items: items ?? this.items,
    );
  }
}

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final PaginationModel<T>? data;

  const PaginatedResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [success, message, data];

  PaginatedResponse<T> copyWith({
    bool? success,
    String? message,
    PaginationModel<T>? data,
  }) {
    return PaginatedResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
