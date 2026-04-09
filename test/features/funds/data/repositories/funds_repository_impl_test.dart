import 'package:ceiba_technical_test/core/error/exceptions.dart';
import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/data/repositories/funds_repository_impl.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late FundsRepositoryImpl repository;
  late MockFundsLocalDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(tFpvFund);
    registerFallbackValue(NotificationType.email);
  });

  setUp(() {
    mockDataSource = MockFundsLocalDataSource();
    repository = FundsRepositoryImpl(mockDataSource);
  });

  group('FundsRepositoryImpl', () {
    group('getAllFunds', () {
      test('retorna Right con fondos cuando el data source tiene éxito',
          () async {
        when(() => mockDataSource.getAllFunds())
            .thenAnswer((_) async => tAllFunds);

        final result = await repository.getAllFunds();

        expect(result, const Right(tAllFunds));
      });

      test('retorna Left(ServerFailure) cuando el data source lanza ServerException',
          () async {
        when(() => mockDataSource.getAllFunds())
            .thenThrow(ServerException('Error del servidor'));

        final result = await repository.getAllFunds();

        expect(result.isLeft(), isTrue);
        expect(result.fold((f) => f, (_) => null), isA<ServerFailure>());
        expect(
          result.fold((f) => f.message, (_) => ''),
          'Error del servidor',
        );
      });

      test('retorna Left(NetworkFailure) cuando el data source lanza NetworkException',
          () async {
        when(() => mockDataSource.getAllFunds())
            .thenThrow(NetworkException('Sin conexión'));

        final result = await repository.getAllFunds();

        expect(result.fold((f) => f, (_) => null), isA<NetworkFailure>());
      });

      test('retorna Left(CacheFailure) cuando el data source lanza CacheException',
          () async {
        when(() => mockDataSource.getAllFunds())
            .thenThrow(CacheException('Error de caché'));

        final result = await repository.getAllFunds();

        expect(result.fold((f) => f, (_) => null), isA<CacheFailure>());
      });

      test(
          'retorna Left(ValidationFailure) cuando el data source lanza ValidationException',
          () async {
        when(() => mockDataSource.getAllFunds())
            .thenThrow(ValidationException('Validación fallida'));

        final result = await repository.getAllFunds();

        expect(result.fold((f) => f, (_) => null), isA<ValidationFailure>());
        expect(result.fold((f) => f.message, (_) => ''), 'Validación fallida');
      });

      test('retorna Left(ServerFailure) para errores desconocidos', () async {
        when(() => mockDataSource.getAllFunds()).thenThrow(Exception('unknown'));

        final result = await repository.getAllFunds();

        expect(result.fold((f) => f, (_) => null), isA<ServerFailure>());
      });
    });

    group('getBalance', () {
      test('retorna Right con saldo cuando el data source tiene éxito',
          () async {
        when(() => mockDataSource.getBalance())
            .thenAnswer((_) async => 500000.0);

        final result = await repository.getBalance();

        expect(result, const Right<Failure, double>(500000.0));
      });

      test('retorna Left(ServerFailure) cuando el data source lanza excepción',
          () async {
        when(() => mockDataSource.getBalance())
            .thenThrow(ServerException('Error'));

        final result = await repository.getBalance();

        expect(result.isLeft(), isTrue);
      });
    });

    group('getSubscriptions', () {
      test('retorna Right con suscripciones cuando el data source tiene éxito',
          () async {
        when(() => mockDataSource.getSubscriptions())
            .thenAnswer((_) async => [tSubscription]);

        final result = await repository.getSubscriptions();

        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => []), [tSubscription]);
      });
    });

    group('getTransactions', () {
      test('retorna Right con transacciones cuando el data source tiene éxito',
          () async {
        when(() => mockDataSource.getTransactions())
            .thenAnswer((_) async => [tTransaction]);

        final result = await repository.getTransactions();

        expect(result.isRight(), isTrue);
      });
    });

    group('subscribe', () {
      test('retorna Right(unit) cuando el data source tiene éxito', () async {
        when(
          () => mockDataSource.subscribe(
            fund: any(named: 'fund'),
            amount: any(named: 'amount'),
            notification: any(named: 'notification'),
          ),
        ).thenAnswer((_) async {});

        final result = await repository.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );

        expect(result, const Right<Failure, Unit>(unit));
      });

      test(
          'retorna Left(ValidationFailure) cuando el data source lanza ValidationException',
          () async {
        when(
          () => mockDataSource.subscribe(
            fund: any(named: 'fund'),
            amount: any(named: 'amount'),
            notification: any(named: 'notification'),
          ),
        ).thenThrow(ValidationException('Saldo insuficiente'));

        final result = await repository.subscribe(
          fund: tFpvFund,
          amount: 999999,
          notification: NotificationType.email,
        );

        expect(result.fold((f) => f, (_) => null), isA<ValidationFailure>());
        expect(
          result.fold((f) => f.message, (_) => ''),
          'Saldo insuficiente',
        );
      });
    });

    group('cancelSubscription', () {
      test('retorna Right(unit) cuando la cancelación es exitosa', () async {
        when(() => mockDataSource.cancelSubscription(fundId: any(named: 'fundId')))
            .thenAnswer((_) async {});

        final result = await repository.cancelSubscription(fundId: 1);

        expect(result, const Right<Failure, Unit>(unit));
      });

      test(
          'retorna Left(ValidationFailure) cuando la suscripción no existe',
          () async {
        when(() => mockDataSource.cancelSubscription(fundId: any(named: 'fundId')))
            .thenThrow(ValidationException('Suscripcion no encontrada'));

        final result = await repository.cancelSubscription(fundId: 99);

        expect(result.fold((f) => f, (_) => null), isA<ValidationFailure>());
      });
    });
  });
}
