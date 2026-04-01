import 'package:flutter_test/flutter_test.dart';
import 'package:ishraf_platform_supervisors/domain/entities/user.dart';
import 'package:ishraf_platform_supervisors/domain/entities/behavior_record.dart';

void main() {
  group('User Entity Tests', () {
    test('User should be created with valid data', () {
      final user = User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        role: UserRole.supervisor,
        phone: '+1234567890',
      );

      expect(user.id, '123');
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
      expect(user.role, UserRole.supervisor);
      expect(user.isSupervisor, true);
      expect(user.isAdmin, false);
    });

    test('User equality should work correctly', () {
      final user1 = User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        role: UserRole.supervisor,
      );

      final user2 = User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        role: UserRole.supervisor,
      );

      final user3 = User(
        id: '456',
        name: 'Different User',
        email: 'different@example.com',
        role: UserRole.admin,
      );

      expect(user1, equals(user2));
      expect(user1, isNot(equals(user3)));
    });
  });

  group('BehaviorRecord Entity Tests', () {
    test('BehaviorRecord should be created with valid data', () {
      final record = BehaviorRecord(
        id: 'rec_123',
        studentId: 'std_456',
        studentName: 'Ahmed Mohamed',
        type: BehaviorType.positive,
        categoryId: 'cat_001',
        categoryName: 'Excellence',
        description: 'Excellent performance in math exam',
        recordedBy: 'sup_789',
        recordedByName: 'Mr. Hassan',
        recordedAt: DateTime(2024, 1, 15, 10, 30),
      );

      expect(record.id, 'rec_123');
      expect(record.studentId, 'std_456');
      expect(record.type, BehaviorType.positive);
      expect(record.isPositive, true);
      expect(record.isNegative, false);
    });

    test('BehaviorRecord status should be pending by default', () {
      final record = BehaviorRecord(
        id: 'rec_123',
        studentId: 'std_456',
        studentName: 'Ahmed Mohamed',
        type: BehaviorType.negative,
        categoryId: 'cat_002',
        categoryName: 'Discipline',
        description: 'Late arrival',
        recordedBy: 'sup_789',
        recordedByName: 'Mr. Hassan',
        recordedAt: DateTime.now(),
      );

      expect(record.status, BehaviorStatus.pending);
      expect(record.isPending, true);
      expect(record.isApproved, false);
    });
  });
}
