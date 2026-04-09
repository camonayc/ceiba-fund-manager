import 'package:ceiba_fund_manager/features/funds/domain/entities/subscription.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Subscription', () {
    final tDate = DateTime(2024, 1, 15);

    group('equatable', () {
      test('dos instancias con el mismo id y fundId son iguales', () {
        final sub1 = Subscription(
          id: 'abc-123',
          fundId: 1,
          fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
          fundCategory: 'FPV',
          amount: 75000,
          minimumAmount: 75000,
          subscribedAt: tDate,
        );
        final sub2 = Subscription(
          id: 'abc-123',
          fundId: 1,
          fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
          fundCategory: 'FPV',
          amount: 75000,
          minimumAmount: 75000,
          subscribedAt: tDate,
        );
        expect(sub1, equals(sub2));
      });

      test('dos instancias con diferente id no son iguales', () {
        final sub1 = Subscription(
          id: 'abc-123',
          fundId: 1,
          fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
          fundCategory: 'FPV',
          amount: 75000,
          minimumAmount: 75000,
          subscribedAt: tDate,
        );
        final sub2 = Subscription(
          id: 'xyz-999',
          fundId: 1,
          fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
          fundCategory: 'FPV',
          amount: 75000,
          minimumAmount: 75000,
          subscribedAt: tDate,
        );
        expect(sub1, isNot(equals(sub2)));
      });
    });

    test('almacena correctamente todos los campos', () {
      final sub = Subscription(
        id: 'test-id',
        fundId: 2,
        fundName: 'FPV_BTG_PACTUAL_ECOPETROL',
        fundCategory: 'FPV',
        amount: 125000,
        minimumAmount: 125000,
        subscribedAt: tDate,
      );

      expect(sub.id, 'test-id');
      expect(sub.fundId, 2);
      expect(sub.fundName, 'FPV_BTG_PACTUAL_ECOPETROL');
      expect(sub.fundCategory, 'FPV');
      expect(sub.amount, 125000);
      expect(sub.minimumAmount, 125000);
      expect(sub.subscribedAt, tDate);
    });
  });
}
