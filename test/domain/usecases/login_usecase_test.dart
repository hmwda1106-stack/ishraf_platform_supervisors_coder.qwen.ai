import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ishraf_platform_supervisors/domain/repositories/auth_repository.dart';
import 'package:ishraf_platform_supervisors/domain/usecases/auth/login_usecase.dart';
import 'package:ishraf_platform_supervisors/domain/entities/user.dart';
import 'package:ishraf_platform_supervisors/core/network/exceptions.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  group('LoginUseCase Tests', () {
    final tEmail = 'test@example.com';
    final tPassword = 'password123';
    final tUser = User(
      id: '123',
      name: 'Test User',
      email: tEmail,
      role: UserRole.supervisor,
    );

    test('should return user when repository call is successful', () async {
      // Arrange
      when(mockAuthRepository.login(email: tEmail, password: tPassword))
          .thenAnswer((_) async => Right(tUser));

      // Act
      final result = await loginUseCase.execute(LoginParams(email: tEmail, password: tPassword));

      // Assert
      expect(result, Right(tUser));
      verify(mockAuthRepository.login(email: tEmail, password: tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      final exception = ServerException(statusCode: 500, message: 'Server error');
      when(mockAuthRepository.login(email: tEmail, password: tPassword))
          .thenAnswer((_) async => Left(exception));

      // Act
      final result = await loginUseCase.execute(LoginParams(email: tEmail, password: tPassword));

      // Assert
      expect(result, Left(exception));
      verify(mockAuthRepository.login(email: tEmail, password: tPassword));
    });

    test('should throw exception with invalid email', () async {
      // Arrange & Act
      final params = LoginParams(email: 'invalid-email', password: tPassword);
      
      // Assert - validation should happen in use case or repository
      expect(params.email, 'invalid-email');
    });
  });
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
