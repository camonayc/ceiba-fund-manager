import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/subscribe_to_fund_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late SubscribeToFundUseCase usecase;
  late MockFundsRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(tFpvFund);
    registerFallbackValue(NotificationType.email);
  });

  setUp(() {
    mockRepository = MockFundsRepository();
    usecase = SubscribeToFundUseCase(mockRepository);
  });

  group('SubscribeToFundUseCase', () {
    test('retorna Right(unit) cuando la suscripción es exitosa', () async {
      when(
        () => mockRepository.subscribe(
          fund: any(named: 'fund'),
          amount: any(named: 'amount'),
          notification: any(named: 'notification'),
        ),
      ).thenAnswer((_) async => const Right(unit));

      final result = await usecase(
        fund: tFpvFund,
        amount: 75000,
        notification: NotificationType.email,
      );

      expect(result, const Right<Failure, Unit>(unit));
      verify(
        () => mockRepository.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retorna Left con ValidationFailure cuando el saldo es insuficiente',
        () async {
      const failure = ValidationFailure('Saldo insuficiente');
      when(
        () => mockRepository.subscribe(
          fund: any(named: 'fund'),
          amount: any(named: 'amount'),
          notification: any(named: 'notification'),
        ),
      ).thenAnswer((_) async => const Left(failure));

      final result = await usecase(
        fund: tFpvFund,
        amount: 999999,
        notification: NotificationType.sms,
      );

      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f.message, (_) => ''), 'Saldo insuficiente');
    });

    test('pasa los parámetros correctos al repositorio', () async {
      when(
        () => mockRepository.subscribe(
          fund: any(named: 'fund'),
          amount: any(named: 'amount'),
          notification: any(named: 'notification'),
        ),
      ).thenAnswer((_) async => const Right(unit));

      await usecase(
        fund: tFicFund,
        amount: 50000,
        notification: NotificationType.sms,
      );

      verify(
        () => mockRepository.subscribe(
          fund: tFicFund,
          amount: 50000,
          notification: NotificationType.sms,
        ),
      ).called(1);
    });
  });
}
