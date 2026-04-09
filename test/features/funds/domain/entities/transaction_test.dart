import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transaction', () {
    final tDate = DateTime(2024, 1, 15);

    group('isSubscription', () {
      test('retorna true cuando el tipo es subscription', () {
        final tx = Transaction(
          id: 'tx-1',
          type: TransactionType.subscription,
          fundId: 1,
          fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
          amount: 75000,
          date: tDate,
        );
        expect(tx.isSubscription, isTrue);
      });

      test('retorna false cuando el tipo es cancellation', () {
        final tx = Transaction(
          id: 'tx-2',
          type: TransactionType.cancellation,
          fundId: 1,
          fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
          amount: 75000,
          date: tDate,
        );
        expect(tx.isSubscription, isFalse);
      });
    });

    group('notification', () {
      test('puede ser null cuando no se especifica', () {
        final tx = Transaction(
          id: 'tx-1',
          type: TransactionType.cancellation,
          fundId: 1,
          fundName: 'TEST',
          amount: 50000,
          date: tDate,
        );
        expect(tx.notification, isNull);
      });

      test('almacena NotificationType.email correctamente', () {
        final tx = Transaction(
          id: 'tx-1',
          type: TransactionType.subscription,
          fundId: 1,
          fundName: 'TEST',
          amount: 50000,
          date: tDate,
          notification: NotificationType.email,
        );
        expect(tx.notification, NotificationType.email);
      });

      test('almacena NotificationType.sms correctamente', () {
        final tx = Transaction(
          id: 'tx-1',
          type: TransactionType.subscription,
          fundId: 1,
          fundName: 'TEST',
          amount: 50000,
          date: tDate,
          notification: NotificationType.sms,
        );
        expect(tx.notification, NotificationType.sms);
      });
    });

    group('equatable', () {
      test('dos instancias con el mismo id son iguales', () {
        final tx1 = Transaction(
          id: 'same-id',
          type: TransactionType.subscription,
          fundId: 1,
          fundName: 'FUND',
          amount: 75000,
          date: tDate,
        );
        final tx2 = Transaction(
          id: 'same-id',
          type: TransactionType.cancellation,
          fundId: 2,
          fundName: 'OTHER',
          amount: 99999,
          date: DateTime(2025, 6, 15),
        );
        expect(tx1, equals(tx2));
      });

      test('dos instancias con diferente id no son iguales', () {
        final tx1 = Transaction(
          id: 'id-1',
          type: TransactionType.subscription,
          fundId: 1,
          fundName: 'FUND',
          amount: 75000,
          date: tDate,
        );
        final tx2 = Transaction(
          id: 'id-2',
          type: TransactionType.subscription,
          fundId: 1,
          fundName: 'FUND',
          amount: 75000,
          date: tDate,
        );
        expect(tx1, isNot(equals(tx2)));
      });
    });
  });
}
