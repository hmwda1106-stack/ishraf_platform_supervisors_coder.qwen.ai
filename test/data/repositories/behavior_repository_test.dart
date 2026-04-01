import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ishraf_platform_supervisors/domain/repositories/behavior_repository.dart';
import 'package:ishraf_platform_supervisors/domain/entities/behavior_record.dart';

@GenerateMocks([BehaviorRepository])
void main() {
  late MockBehaviorRepository mockBehaviorRepository;

  setUp(() {
    mockBehaviorRepository = MockBehaviorRepository();
  });

  group('BehaviorRepository Tests', () {
    final tBehaviorRecords = [
      BehaviorRecord(
        id: 'rec_1',
        studentId: 'std_1',
        studentName: 'Ahmed',
        type: BehaviorType.positive,
        categoryId: 'cat_1',
        categoryName: 'Excellence',
        description: 'Great work',
        recordedBy: 'sup_1',
        recordedByName: 'Mr. Hassan',
        recordedAt: DateTime.now(),
      ),
    ];

    test('should return list of behavior records when successful', () async {
      // Arrange
      when(mockBehaviorRepository.getBehaviorRecords(
        page: 1,
        limit: 20,
      )).thenAnswer((_) async => Right(tBehaviorRecords));

      // Act
      final result = await mockBehaviorRepository.getBehaviorRecords(page: 1, limit: 20);

      // Assert
      expect(result, Right(tBehaviorRecords));
      verify(mockBehaviorRepository.getBehaviorRecords(page: 1, limit: 20));
    });

    test('should add behavior record successfully', () async {
      // Arrange
      final newRecord = tBehaviorRecords.first;
      when(mockBehaviorRepository.addBehaviorRecord(record: newRecord))
          .thenAnswer((_) async => Right(newRecord));

      // Act
      final result = await mockBehaviorRepository.addBehaviorRecord(record: newRecord);

      // Assert
      expect(result, Right(newRecord));
      verify(mockBehaviorRepository.addBehaviorRecord(record: newRecord));
    });
  });
}
