import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba_fund_manager/core/error/failures.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_event.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late FundsBloc bloc;
  late MockGetAllFundsUseCase mockGetAllFunds;
  late MockGetSubscriptionsUseCase mockGetSubscriptions;
  late MockGetTransactionsUseCase mockGetTransactions;
  late MockGetBalanceUseCase mockGetBalance;
  late MockSubscribeToFundUseCase mockSubscribeToFund;
  late MockCancelSubscriptionUseCase mockCancelSubscription;

  setUpAll(() {
    registerFallbackValue(tFpvFund);
    registerFallbackValue(NotificationType.email);
  });

  setUp(() {
    mockGetAllFunds = MockGetAllFundsUseCase();
    mockGetSubscriptions = MockGetSubscriptionsUseCase();
    mockGetTransactions = MockGetTransactionsUseCase();
    mockGetBalance = MockGetBalanceUseCase();
    mockSubscribeToFund = MockSubscribeToFundUseCase();
    mockCancelSubscription = MockCancelSubscriptionUseCase();

    bloc = FundsBloc(
      getAllFunds: mockGetAllFunds,
      getSubscriptions: mockGetSubscriptions,
      getTransactions: mockGetTransactions,
      getBalance: mockGetBalance,
      subscribeToFund: mockSubscribeToFund,
      cancelSubscription: mockCancelSubscription,
    );
  });

  tearDown(() => bloc.close());

  void stubReloadSuccess() {
    when(() => mockGetAllFunds())
        .thenAnswer((_) async => const Right(tAllFunds));
    when(() => mockGetSubscriptions())
        .thenAnswer((_) async => Right([tSubscription]));
    when(() => mockGetTransactions())
        .thenAnswer((_) async => Right([tTransaction]));
    when(() => mockGetBalance()).thenAnswer((_) async => const Right(500000.0));
  }

  group('FundsBloc', () {
    test('estado inicial es FundsState()', () {
      expect(bloc.state, const FundsState());
    });

    group('FundsLoadRequested', () {
      blocTest<FundsBloc, FundsState>(
        'emite [loading, success] cuando todos los use cases tienen éxito',
        build: () {
          stubReloadSuccess();
          return bloc;
        },
        act: (b) => b.add(const FundsLoadRequested()),
        expect: () => [
          const FundsState(status: FundsStatus.loading),
          FundsState(
            status: FundsStatus.success,
            allFunds: tAllFunds,
            subscriptions: [tSubscription],
            transactions: [tTransaction],
            balance: 500000.0,
          ),
        ],
      );

      blocTest<FundsBloc, FundsState>(
        'emite [loading, failure] cuando getAllFunds falla',
        build: () {
          when(() => mockGetAllFunds()).thenAnswer(
            (_) async => const Left(ServerFailure('Error del servidor')),
          );
          return bloc;
        },
        act: (b) => b.add(const FundsLoadRequested()),
        expect: () => [
          const FundsState(status: FundsStatus.loading),
          const FundsState(
            status: FundsStatus.failure,
            errorMessage: 'Error del servidor',
          ),
        ],
      );

      blocTest<FundsBloc, FundsState>(
        'emite [loading, failure] cuando getSubscriptions falla',
        build: () {
          when(() => mockGetAllFunds())
              .thenAnswer((_) async => const Right(tAllFunds));
          when(() => mockGetSubscriptions()).thenAnswer(
            (_) async =>
                const Left(NetworkFailure('Sin conexión')),
          );
          return bloc;
        },
        act: (b) => b.add(const FundsLoadRequested()),
        expect: () => [
          const FundsState(status: FundsStatus.loading),
          const FundsState(
            status: FundsStatus.failure,
            errorMessage: 'Sin conexión',
          ),
        ],
      );

      blocTest<FundsBloc, FundsState>(
        'emite [loading, failure] cuando getBalance falla',
        build: () {
          when(() => mockGetAllFunds())
              .thenAnswer((_) async => const Right(tAllFunds));
          when(() => mockGetSubscriptions())
              .thenAnswer((_) async => Right([tSubscription]));
          when(() => mockGetTransactions())
              .thenAnswer((_) async => Right([tTransaction]));
          when(() => mockGetBalance()).thenAnswer(
            (_) async => const Left(ServerFailure('Error de saldo')),
          );
          return bloc;
        },
        act: (b) => b.add(const FundsLoadRequested()),
        expect: () => [
          const FundsState(status: FundsStatus.loading),
          const FundsState(
            status: FundsStatus.failure,
            errorMessage: 'Error de saldo',
          ),
        ],
      );
    });

    group('FundsSubscribeRequested', () {
      blocTest<FundsBloc, FundsState>(
        'emite estado con errorMessage cuando la suscripción falla',
        build: () {
          when(
            () => mockSubscribeToFund(
              fund: any(named: 'fund'),
              amount: any(named: 'amount'),
              notification: any(named: 'notification'),
            ),
          ).thenAnswer(
            (_) async =>
                const Left(ValidationFailure('Saldo insuficiente')),
          );
          return bloc;
        },
        seed: () => const FundsState(
          status: FundsStatus.success,
          balance: 500000,
        ),
        act: (b) => b.add(
          const FundsSubscribeRequested(
            fund: tFpvFund,
            amount: 999999,
            notification: NotificationType.email,
          ),
        ),
        expect: () => [
          const FundsState(
            status: FundsStatus.success,
            balance: 500000,
            errorMessage: 'Saldo insuficiente',
          ),
        ],
      );

      blocTest<FundsBloc, FundsState>(
        'recarga todos los datos cuando la suscripción es exitosa',
        build: () {
          when(
            () => mockSubscribeToFund(
              fund: any(named: 'fund'),
              amount: any(named: 'amount'),
              notification: any(named: 'notification'),
            ),
          ).thenAnswer((_) async => const Right(unit));
          stubReloadSuccess();
          return bloc;
        },
        act: (b) => b.add(
          const FundsSubscribeRequested(
            fund: tFpvFund,
            amount: 75000,
            notification: NotificationType.email,
          ),
        ),
        expect: () => [
          FundsState(
            status: FundsStatus.success,
            allFunds: tAllFunds,
            subscriptions: [tSubscription],
            transactions: [tTransaction],
            balance: 500000.0,
          ),
        ],
      );
    });

    group('FundsCancelRequested', () {
      blocTest<FundsBloc, FundsState>(
        'emite estado con errorMessage cuando la cancelación falla',
        build: () {
          when(
            () => mockCancelSubscription(fundId: any(named: 'fundId')),
          ).thenAnswer(
            (_) async =>
                const Left(ValidationFailure('Suscripcion no encontrada')),
          );
          return bloc;
        },
        seed: () => FundsState(
          status: FundsStatus.success,
          subscriptions: [tSubscription],
        ),
        act: (b) => b.add(const FundsCancelRequested(fundId: 99)),
        expect: () => [
          FundsState(
            status: FundsStatus.success,
            subscriptions: [tSubscription],
            errorMessage: 'Suscripcion no encontrada',
          ),
        ],
      );

      blocTest<FundsBloc, FundsState>(
        'recarga todos los datos cuando la cancelación es exitosa',
        build: () {
          when(
            () => mockCancelSubscription(fundId: any(named: 'fundId')),
          ).thenAnswer((_) async => const Right(unit));
          stubReloadSuccess();
          return bloc;
        },
        seed: () => FundsState(
          status: FundsStatus.success,
          subscriptions: [tSubscription],
        ),
        act: (b) => b.add(const FundsCancelRequested(fundId: 1)),
        expect: () => [
          FundsState(
            status: FundsStatus.success,
            allFunds: tAllFunds,
            subscriptions: [tSubscription],
            transactions: [tTransaction],
            balance: 500000.0,
          ),
        ],
      );
    });

    group('FundsErrorCleared', () {
      blocTest<FundsBloc, FundsState>(
        'limpia el error y recarga los datos',
        build: () {
          stubReloadSuccess();
          return bloc;
        },
        seed: () => const FundsState(
          status: FundsStatus.failure,
          errorMessage: 'Error previo',
        ),
        act: (b) => b.add(const FundsErrorCleared()),
        expect: () => [
          const FundsState(status: FundsStatus.loading),
          FundsState(
            status: FundsStatus.success,
            allFunds: tAllFunds,
            subscriptions: [tSubscription],
            transactions: [tTransaction],
            balance: 500000.0,
          ),
        ],
      );
    });
  });
}
