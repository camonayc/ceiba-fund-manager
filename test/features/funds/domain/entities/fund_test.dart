import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fund', () {
    group('categoryLabel', () {
      test('retorna "FPV" para fondos de categoría fpv', () {
        const fund = Fund(
          id: 1,
          name: 'FPV_BTG_PACTUAL_RECAUDADORA',
          category: FundCategory.fpv,
          minimumAmount: 75000,
        );
        expect(fund.categoryLabel, 'FPV');
      });

      test('retorna "FIC" para fondos de categoría fic', () {
        const fund = Fund(
          id: 3,
          name: 'DEUDAPRIVADA',
          category: FundCategory.fic,
          minimumAmount: 50000,
        );
        expect(fund.categoryLabel, 'FIC');
      });
    });

    group('equatable', () {
      test('dos instancias con los mismos valores son iguales', () {
        const fund1 = Fund(
          id: 1,
          name: 'FPV_BTG_PACTUAL_RECAUDADORA',
          category: FundCategory.fpv,
          minimumAmount: 75000,
        );
        const fund2 = Fund(
          id: 1,
          name: 'FPV_BTG_PACTUAL_RECAUDADORA',
          category: FundCategory.fpv,
          minimumAmount: 75000,
        );
        expect(fund1, equals(fund2));
      });

      test('dos instancias con diferente id no son iguales', () {
        const fund1 = Fund(
          id: 1,
          name: 'FPV_BTG_PACTUAL_RECAUDADORA',
          category: FundCategory.fpv,
          minimumAmount: 75000,
        );
        const fund2 = Fund(
          id: 2,
          name: 'FPV_BTG_PACTUAL_RECAUDADORA',
          category: FundCategory.fpv,
          minimumAmount: 75000,
        );
        expect(fund1, isNot(equals(fund2)));
      });

      test('dos instancias con diferente categoría no son iguales', () {
        const fund1 = Fund(
          id: 1,
          name: 'FUND',
          category: FundCategory.fpv,
          minimumAmount: 75000,
        );
        const fund2 = Fund(
          id: 1,
          name: 'FUND',
          category: FundCategory.fic,
          minimumAmount: 75000,
        );
        expect(fund1, isNot(equals(fund2)));
      });
    });

    group('props', () {
      test('incluye id, name, category y minimumAmount', () {
        const fund = Fund(
          id: 1,
          name: 'TEST_FUND',
          category: FundCategory.fpv,
          minimumAmount: 100000,
        );
        expect(fund.props, [1, 'TEST_FUND', FundCategory.fpv, 100000.0]);
      });
    });
  });
}
