import 'package:ceiba_fund_manager/core/error/failures.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_fund_manager/features/funds/domain/usecases/get_subscriptions_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late GetSubscriptionsUseCase usecase;
  late MockFundsRepository mockRepository;

  setUp(() {
    mockRepository = MockFundsRepository();
    usecase = GetSubscriptionsUseCase(mockRepository);
  });

  group('GetSubscriptionsUseCase', () {
    test('retorna Right con la lista de suscripciones cuando el repositorio tiene éxito',
        () async {
      final tSubscriptions = [tSubscription];
      when(() => mockRepository.getSubscriptions())
          .thenAnswer((_) async => Right(tSubscriptions));

      final result = await usecase();

      expect(result, Right<Failure, List<Subscription>>(tSubscriptions));
      verify(() => mockRepository.getSubscriptions()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retorna Right con lista vacía cuando no hay suscripciones', () async {
      when(() => mockRepository.getSubscriptions())
          .thenAnswer((_) async => const Right([]));

      final result = await usecase();

      expect(result.getOrElse(() => [tSubscription]), isEmpty);
    });

    test('retorna Left con Failure cuando el repositorio falla', () async {
      const failure = ServerFailure('Error al obtener suscripciones');
      when(() => mockRepository.getSubscriptions())
          .thenAnswer((_) async => const Left(failure));

      final result = await usecase();

      expect(result, const Left<Failure, dynamic>(failure));
    });
  });
}
