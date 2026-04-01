import 'package:equatable/equatable.dart';

enum Gender {
  male,
  female,
}

enum StudentStatus {
  active,
  inactive,
  graduated,
}

class Student extends Equatable {
  final String id;
  final String name;
  final String? studentNumber;
  final DateTime dateOfBirth;
  final Gender gender;
  final StudentStatus status;
  final String? grade;
  final String? className;
  final String? parentId;
  final String? parentName;
  final String? parentPhone;
  final String? photoUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Student({
    required this.id,
    required this.name,
    this.studentNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.status,
    this.grade,
    this.className,
    this.parentId,
    this.parentName,
    this.parentPhone,
    this.photoUrl,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  bool get isMale => gender == Gender.male;
  bool get isFemale => gender == Gender.female;
  bool get isActive => status == StudentStatus.active;

  @override
  List<Object?> get props => [
        id,
        name,
        studentNumber,
        dateOfBirth,
        gender,
        status,
        grade,
        className,
        parentId,
        parentName,
        parentPhone,
        photoUrl,
        notes,
        createdAt,
        updatedAt,
      ];

  Student copyWith({
    String? id,
    String? name,
    String? studentNumber,
    DateTime? dateOfBirth,
    Gender? gender,
    StudentStatus? status,
    String? grade,
    String? className,
    String? parentId,
    String? parentName,
    String? parentPhone,
    String? photoUrl,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      studentNumber: studentNumber ?? this.studentNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      grade: grade ?? this.grade,
      className: className ?? this.className,
      parentId: parentId ?? this.parentId,
      parentName: parentName ?? this.parentName,
      parentPhone: parentPhone ?? this.parentPhone,
      photoUrl: photoUrl ?? this.photoUrl,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
