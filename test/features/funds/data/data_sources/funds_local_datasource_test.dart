import 'package:ceiba_technical_test/core/error/exceptions.dart';
import 'package:ceiba_technical_test/features/funds/data/data_sources/funds_local_datasource.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FundsLocalDataSourceImpl dataSource;

  const tFpvFund = Fund(
    id: 1,
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    category: FundCategory.fpv,
    minimumAmount: 75000,
  );

  const tFicFund = Fund(
    id: 3,
    name: 'DEUDAPRIVADA',
    category: FundCategory.fic,
    minimumAmount: 50000,
  );

  setUp(() {
    dataSource = FundsLocalDataSourceImpl();
  });

  group('FundsLocalDataSourceImpl', () {
    group('getAllFunds', () {
      test('retorna exactamente 5 fondos', () async {
        final funds = await dataSource.getAllFunds();
        expect(funds, hasLength(5));
      });

      test('incluye fondos FPV y FIC', () async {
        final funds = await dataSource.getAllFunds();
        final categories = funds.map((f) => f.category).toSet();
        expect(categories, containsAll([FundCategory.fpv, FundCategory.fic]));
      });

      test('el primer fondo es FPV_BTG_PACTUAL_RECAUDADORA con mínimo 75.000',
          () async {
        final funds = await dataSource.getAllFunds();
        expect(funds.first.name, 'FPV_BTG_PACTUAL_RECAUDADORA');
        expect(funds.first.minimumAmount, 75000);
      });

      test('retorna una lista no modificable', () async {
        final funds = await dataSource.getAllFunds();
        expect(() => (funds as dynamic).add(tFpvFund), throwsUnsupportedError);
      });
    });

    group('getBalance', () {
      test('retorna 500.000 como saldo inicial', () async {
        final balance = await dataSource.getBalance();
        expect(balance, 500000.0);
      });
    });

    group('getSubscriptions', () {
      test('retorna lista vacía inicialmente', () async {
        final subs = await dataSource.getSubscriptions();
        expect(subs, isEmpty);
      });
    });

    group('getTransactions', () {
      test('retorna lista vacía inicialmente', () async {
        final txs = await dataSource.getTransactions();
        expect(txs, isEmpty);
      });
    });

    group('subscribe', () {
      test('descuenta el monto del saldo correctamente', () async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );

        final balance = await dataSource.getBalance();
        expect(balance, 425000.0);
      });

      test('agrega la suscripción a la lista', () async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );

        final subs = await dataSource.getSubscriptions();
        expect(subs, hasLength(1));
        expect(subs.first.fundId, tFpvFund.id);
        expect(subs.first.amount, 75000);
      });

      test('registra una transacción de tipo subscription', () async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.sms,
        );

        final txs = await dataSource.getTransactions();
        expect(txs, hasLength(1));
        expect(txs.first.type, TransactionType.subscription);
        expect(txs.first.fundId, tFpvFund.id);
        expect(txs.first.notification, NotificationType.sms);
      });

      test('almacena el tipo de notificación en la transacción', () async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );

        final txs = await dataSource.getTransactions();
        expect(txs.first.notification, NotificationType.email);
      });

      test('lanza ValidationException cuando el saldo es insuficiente',
          () async {
        expect(
          () => dataSource.subscribe(
            fund: tFpvFund,
            amount: 600000,
            notification: NotificationType.email,
          ),
          throwsA(
            isA<ValidationException>().having(
              (e) => e.message,
              'message',
              'Saldo insuficiente',
            ),
          ),
        );
      });

      test('lanza ValidationException cuando el monto es menor al mínimo',
          () async {
        expect(
          () => dataSource.subscribe(
            fund: tFpvFund,
            amount: 10000,
            notification: NotificationType.email,
          ),
          throwsA(
            isA<ValidationException>().having(
              (e) => e.message,
              'message',
              'El monto es menor al mínimo requerido',
            ),
          ),
        );
      });

      test('lanza ValidationException cuando ya existe suscripción al fondo',
          () async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );

        expect(
          () => dataSource.subscribe(
            fund: tFpvFund,
            amount: 75000,
            notification: NotificationType.email,
          ),
          throwsA(
            isA<ValidationException>().having(
              (e) => e.message,
              'message',
              'Ya estas suscrito a este fondo',
            ),
          ),
        );
      });

      test('permite suscribirse a dos fondos diferentes', () async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );
        await dataSource.subscribe(
          fund: tFicFund,
          amount: 50000,
          notification: NotificationType.sms,
        );

        final subs = await dataSource.getSubscriptions();
        expect(subs, hasLength(2));
      });
    });

    group('cancelSubscription', () {
      setUp(() async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );
      });

      test('reintegra el monto al saldo', () async {
        await dataSource.cancelSubscription(fundId: tFpvFund.id);

        final balance = await dataSource.getBalance();
        expect(balance, 500000.0);
      });

      test('elimina la suscripción de la lista', () async {
        await dataSource.cancelSubscription(fundId: tFpvFund.id);

        final subs = await dataSource.getSubscriptions();
        expect(subs, isEmpty);
      });

      test('registra una transacción de tipo cancellation', () async {
        await dataSource.cancelSubscription(fundId: tFpvFund.id);

        final txs = await dataSource.getTransactions();
        final cancellations = txs.where(
          (t) => t.type == TransactionType.cancellation,
        );
        expect(cancellations, hasLength(1));
        expect(cancellations.first.fundId, tFpvFund.id);
      });

      test('la transacción de cancelación no tiene notificación', () async {
        await dataSource.cancelSubscription(fundId: tFpvFund.id);

        final txs = await dataSource.getTransactions();
        final cancellation = txs.firstWhere(
          (t) => t.type == TransactionType.cancellation,
        );
        expect(cancellation.notification, isNull);
      });

      test('lanza ValidationException cuando la suscripción no existe',
          () async {
        expect(
          () => dataSource.cancelSubscription(fundId: 99),
          throwsA(
            isA<ValidationException>().having(
              (e) => e.message,
              'message',
              'Suscripcion no encontrada',
            ),
          ),
        );
      });
    });

    group('getTransactions - orden', () {
      test('retorna transacciones en orden cronológico inverso', () async {
        await dataSource.subscribe(
          fund: tFpvFund,
          amount: 75000,
          notification: NotificationType.email,
        );
        await dataSource.subscribe(
          fund: tFicFund,
          amount: 50000,
          notification: NotificationType.sms,
        );

        final txs = await dataSource.getTransactions();

        expect(txs.first.fundId, tFicFund.id);
        expect(txs.last.fundId, tFpvFund.id);
      });
    });
  });
}
