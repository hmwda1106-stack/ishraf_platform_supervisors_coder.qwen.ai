import 'package:equatable/equatable.dart';

enum UserRole {
  supervisor,
  driver,
  teacher,
  admin,
}

enum UserStatus {
  active,
  inactive,
  suspended,
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;
  final UserStatus status;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    required this.status,
    this.profileImageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isSupervisor => role == UserRole.supervisor;
  bool get isDriver => role == UserRole.driver;
  bool get isTeacher => role == UserRole.teacher;
  bool get isAdmin => role == UserRole.admin;
  bool get isActive => status == UserStatus.active;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        role,
        status,
        profileImageUrl,
        createdAt,
        updatedAt,
      ];

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    UserStatus? status,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
