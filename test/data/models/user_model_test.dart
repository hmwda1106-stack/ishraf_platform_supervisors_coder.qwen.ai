import 'package:flutter_test/flutter_test.dart';
import 'package:ishraf_platform_supervisors/data/models/user_model.dart';
import 'package:ishraf_platform_supervisors/domain/entities/user.dart';

void main() {
  group('UserModel Tests', () {
    final tUserModel = UserModel(
      id: '123',
      name: 'Test User',
      email: 'test@example.com',
      role: UserRole.supervisor,
      phone: '+1234567890',
    );

    test('should create UserModel from JSON', () {
      final jsonMap = {
        'id': '123',
        'name': 'Test User',
        'email': 'test@example.com',
        'role': 'supervisor',
        'phone': '+1234567890',
      };

      final userModel = UserModel.fromJson(jsonMap);

      expect(userModel.id, '123');
      expect(userModel.name, 'Test User');
      expect(userModel.email, 'test@example.com');
      expect(userModel.role, UserRole.supervisor);
    });

    test('should convert UserModel to JSON', () {
      final jsonMap = tUserModel.toJson();

      expect(jsonMap['id'], '123');
      expect(jsonMap['name'], 'Test User');
      expect(jsonMap['email'], 'test@example.com');
      expect(jsonMap['role'], 'supervisor');
    });

    test('should convert UserModel to User entity', () {
      final userEntity = tUserModel.toEntity();

      expect(userEntity.id, '123');
      expect(userEntity.name, 'Test User');
      expect(userEntity.email, 'test@example.com');
      expect(userEntity.role, UserRole.supervisor);
    });

    test('UserModel equality should work correctly', () {
      final userModel1 = UserModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        role: UserRole.supervisor,
      );

      final userModel2 = UserModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        role: UserRole.supervisor,
      );

      final userModel3 = UserModel(
        id: '456',
        name: 'Different User',
        email: 'different@example.com',
        role: UserRole.admin,
      );

      expect(userModel1, equals(userModel2));
      expect(userModel1, isNot(equals(userModel3)));
    });
  });
}
