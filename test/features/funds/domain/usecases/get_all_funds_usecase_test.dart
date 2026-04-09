import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/get_all_funds_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late GetAllFundsUseCase usecase;
  late MockFundsRepository mockRepository;

  setUp(() {
    mockRepository = MockFundsRepository();
    usecase = GetAllFundsUseCase(mockRepository);
  });

  group('GetAllFundsUseCase', () {
    test('retorna Right con la lista de fondos cuando el repositorio tiene éxito',
        () async {
      when(() => mockRepository.getAllFunds())
          .thenAnswer((_) async => const Right(tAllFunds));

      final result = await usecase();

      expect(result, const Right<Failure, dynamic>(tAllFunds));
      verify(() => mockRepository.getAllFunds()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retorna Left con Failure cuando el repositorio falla', () async {
      const failure = ServerFailure('Error del servidor');
      when(() => mockRepository.getAllFunds())
          .thenAnswer((_) async => const Left(failure));

      final result = await usecase();

      expect(result, const Left<Failure, dynamic>(failure));
      verify(() => mockRepository.getAllFunds()).called(1);
    });

    test('delega la llamada al repositorio sin modificar el resultado',
        () async {
      when(() => mockRepository.getAllFunds())
          .thenAnswer((_) async => const Right([]));

      final result = await usecase();

      expect(result.isRight(), isTrue);
    });
  });
}
