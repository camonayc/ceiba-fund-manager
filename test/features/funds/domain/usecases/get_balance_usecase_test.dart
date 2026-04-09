import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/get_balance_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late GetBalanceUseCase usecase;
  late MockFundsRepository mockRepository;

  setUp(() {
    mockRepository = MockFundsRepository();
    usecase = GetBalanceUseCase(mockRepository);
  });

  group('GetBalanceUseCase', () {
    test('retorna Right con el saldo cuando el repositorio tiene éxito',
        () async {
      const tBalance = 500000.0;
      when(() => mockRepository.getBalance())
          .thenAnswer((_) async => const Right(tBalance));

      final result = await usecase();

      expect(result, const Right<Failure, double>(tBalance));
      verify(() => mockRepository.getBalance()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retorna Left con Failure cuando el repositorio falla', () async {
      const failure = ServerFailure('Error al obtener saldo');
      when(() => mockRepository.getBalance())
          .thenAnswer((_) async => const Left(failure));

      final result = await usecase();

      expect(result, const Left<Failure, double>(failure));
      verify(() => mockRepository.getBalance()).called(1);
    });

    test('retorna saldo cero correctamente', () async {
      when(() => mockRepository.getBalance())
          .thenAnswer((_) async => const Right(0.0));

      final result = await usecase();

      expect(result.getOrElse(() => -1), 0.0);
    });
  });
}
