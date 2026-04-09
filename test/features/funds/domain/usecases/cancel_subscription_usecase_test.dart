import 'package:ceiba_fund_manager/core/error/failures.dart';
import 'package:ceiba_fund_manager/features/funds/domain/usecases/cancel_subscription_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late CancelSubscriptionUseCase usecase;
  late MockFundsRepository mockRepository;

  setUp(() {
    mockRepository = MockFundsRepository();
    usecase = CancelSubscriptionUseCase(mockRepository);
  });

  group('CancelSubscriptionUseCase', () {
    test('retorna Right(unit) cuando la cancelación es exitosa', () async {
      when(() => mockRepository.cancelSubscription(fundId: any(named: 'fundId')))
          .thenAnswer((_) async => const Right(unit));

      final result = await usecase(fundId: 1);

      expect(result, const Right<Failure, Unit>(unit));
      verify(() => mockRepository.cancelSubscription(fundId: 1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retorna Left con ValidationFailure cuando la suscripción no existe',
        () async {
      const failure = ValidationFailure('Suscripcion no encontrada');
      when(() => mockRepository.cancelSubscription(fundId: any(named: 'fundId')))
          .thenAnswer((_) async => const Left(failure));

      final result = await usecase(fundId: 99);

      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f.message, (_) => ''), 'Suscripcion no encontrada');
    });

    test('pasa el fundId correcto al repositorio', () async {
      when(() => mockRepository.cancelSubscription(fundId: any(named: 'fundId')))
          .thenAnswer((_) async => const Right(unit));

      await usecase(fundId: 3);

      verify(() => mockRepository.cancelSubscription(fundId: 3)).called(1);
    });
  });
}
