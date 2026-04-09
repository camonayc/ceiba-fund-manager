import 'package:ceiba_technical_test/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_fixtures.dart';

void main() {
  group('FundsState', () {
    group('estado inicial', () {
      test('tiene status initial por defecto', () {
        const state = FundsState();
        expect(state.status, FundsStatus.initial);
      });

      test('tiene listas vacías por defecto', () {
        const state = FundsState();
        expect(state.allFunds, isEmpty);
        expect(state.subscriptions, isEmpty);
        expect(state.transactions, isEmpty);
      });

      test('tiene saldo 0 por defecto', () {
        const state = FundsState();
        expect(state.balance, 0.0);
      });

      test('no tiene mensaje de error por defecto', () {
        const state = FundsState();
        expect(state.errorMessage, isNull);
      });
    });

    group('availableFunds', () {
      test('retorna todos los fondos cuando no hay suscripciones', () {
        const state = FundsState(allFunds: tAllFunds);
        expect(state.availableFunds, tAllFunds);
      });

      test('excluye los fondos a los que ya está suscrito', () {
        final state = FundsState(
          allFunds: tAllFunds,
          subscriptions: [tSubscription],
        );
        final available = state.availableFunds;
        expect(available, hasLength(1));
        expect(available.first.id, tFicFund.id);
      });

      test('retorna lista vacía cuando está suscrito a todos los fondos', () {
        final subToFic = Subscription(
          id: 'sub-fic-id',
          fundId: tFicFund.id,
          fundName: tFicFund.name,
          fundCategory: tFicFund.categoryLabel,
          amount: 50000,
          minimumAmount: tFicFund.minimumAmount,
          subscribedAt: DateTime(2024, 3, 10),
        );
        final state = FundsState(
          allFunds: tAllFunds,
          subscriptions: [tSubscription, subToFic],
        );
        expect(state.availableFunds, isEmpty);
      });

      test('retorna lista vacía cuando no hay fondos cargados', () {
        const state = FundsState();
        expect(state.availableFunds, isEmpty);
      });
    });

    group('copyWith', () {
      test('actualiza el status correctamente', () {
        const state = FundsState();
        final updated = state.copyWith(status: FundsStatus.loading);
        expect(updated.status, FundsStatus.loading);
      });

      test('mantiene los valores anteriores cuando no se especifican', () {
        const state = FundsState(
          status: FundsStatus.success,
          allFunds: tAllFunds,
          balance: 500000,
        );
        final updated = state.copyWith(balance: 425000);
        expect(updated.status, FundsStatus.success);
        expect(updated.allFunds, tAllFunds);
        expect(updated.balance, 425000);
      });

      test('clearError elimina el mensaje de error', () {
        const state = FundsState(errorMessage: 'Saldo insuficiente');
        final updated = state.copyWith(clearError: true);
        expect(updated.errorMessage, isNull);
      });

      test('preserva el errorMessage cuando clearError es false', () {
        const state = FundsState(errorMessage: 'Error previo');
        final updated = state.copyWith(status: FundsStatus.loading);
        expect(updated.errorMessage, 'Error previo');
      });

      test('actualiza el errorMessage cuando se proporciona uno nuevo', () {
        const state = FundsState();
        final updated = state.copyWith(errorMessage: 'Nuevo error');
        expect(updated.errorMessage, 'Nuevo error');
      });
    });

    group('equatable', () {
      test('dos estados con los mismos valores son iguales', () {
        const state1 = FundsState(status: FundsStatus.loading);
        const state2 = FundsState(status: FundsStatus.loading);
        expect(state1, equals(state2));
      });

      test('dos estados con diferente status no son iguales', () {
        const state1 = FundsState(status: FundsStatus.loading);
        const state2 = FundsState(status: FundsStatus.success);
        expect(state1, isNot(equals(state2)));
      });

      test('dos estados con diferente balance no son iguales', () {
        const state1 = FundsState(balance: 500000);
        const state2 = FundsState(balance: 425000);
        expect(state1, isNot(equals(state2)));
      });
    });
  });
}
