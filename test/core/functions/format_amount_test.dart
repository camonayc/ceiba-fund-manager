import 'package:ceiba_fund_manager/core/functions/format_amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatAmount', () {
    test('formatea correctamente montos de 6 dígitos (500.000)', () {
      expect(formatAmount(500000), '500.000');
    });

    test('formatea correctamente montos de 7 dígitos (1.000.000)', () {
      expect(formatAmount(1000000), '1.000.000');
    });

    test('formatea correctamente montos de 5 dígitos (75.000)', () {
      expect(formatAmount(75000), '75.000');
    });

    test('formatea correctamente montos de 5 dígitos (50.000)', () {
      expect(formatAmount(50000), '50.000');
    });

    test('formatea correctamente montos de 6 dígitos (125.000)', () {
      expect(formatAmount(125000), '125.000');
    });

    test('formatea correctamente montos de 6 dígitos (250.000)', () {
      expect(formatAmount(250000), '250.000');
    });

    test('no agrega punto a montos de 3 dígitos o menos (100)', () {
      expect(formatAmount(100), '100');
    });

    test('no agrega punto a montos de 2 dígitos (50)', () {
      expect(formatAmount(50), '50');
    });

    test('formatea cero correctamente', () {
      expect(formatAmount(0), '0');
    });

    test('formatea correctamente montos de 4 dígitos (1.000)', () {
      expect(formatAmount(1000), '1.000');
    });

    test('redondea hacia abajo cuando el decimal es menor a 0.5', () {
      expect(formatAmount(500000.4), '500.000');
    });

    test('redondea hacia arriba cuando el decimal es 0.5 o mayor', () {
      expect(formatAmount(500000.5), '500.001');
    });
  });
}
