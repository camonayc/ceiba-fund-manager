import 'package:ceiba_fund_manager/core/error/failures.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_fund_manager/features/funds/domain/usecases/get_transactions_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late GetTransactionsUseCase usecase;
  late MockFundsRepository mockRepository;

  setUp(() {
    mockRepository = MockFundsRepository();
    usecase = GetTransactionsUseCase(mockRepository);
  });

  group('GetTransactionsUseCase', () {
    test('retorna Right con la lista de transacciones cuando el repositorio tiene éxito',
        () async {
      final tTransactions = [tTransaction];
      when(() => mockRepository.getTransactions())
          .thenAnswer((_) async => Right(tTransactions));

      final result = await usecase();

      expect(result, Right<Failure, List<Transaction>>(tTransactions));
      verify(() => mockRepository.getTransactions()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retorna Right con lista vacía cuando no hay transacciones', () async {
      when(() => mockRepository.getTransactions())
          .thenAnswer((_) async => const Right([]));

      final result = await usecase();

      expect(result.getOrElse(() => [tTransaction]), isEmpty);
    });

    test('retorna Left con Failure cuando el repositorio falla', () async {
      const failure = NetworkFailure('Sin conexión');
      when(() => mockRepository.getTransactions())
          .thenAnswer((_) async => const Left(failure));

      final result = await usecase();

      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f, (_) => null), failure);
    });
  });
}
