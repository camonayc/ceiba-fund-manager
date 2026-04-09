import 'package:ceiba_fund_manager/core/functions/format_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatDate', () {
    test('formatea enero correctamente', () {
      expect(formatDate(DateTime(2024, 1, 15)), '15 de ene de 2024');
    });

    test('formatea febrero correctamente', () {
      expect(formatDate(DateTime(2024, 2, 5)), '5 de feb de 2024');
    });

    test('formatea marzo correctamente', () {
      expect(formatDate(DateTime(2024, 3, 20)), '20 de mar de 2024');
    });

    test('formatea abril correctamente', () {
      expect(formatDate(DateTime(2024, 4, 10)), '10 de abr de 2024');
    });

    test('formatea mayo correctamente', () {
      expect(formatDate(DateTime(2024, 5, 8)), '8 de may de 2024');
    });

    test('formatea junio correctamente', () {
      expect(formatDate(DateTime(2024, 6, 30)), '30 de jun de 2024');
    });

    test('formatea julio correctamente', () {
      expect(formatDate(DateTime(2024, 7, 4)), '4 de jul de 2024');
    });

    test('formatea agosto correctamente', () {
      expect(formatDate(DateTime(2024, 8, 15)), '15 de ago de 2024');
    });

    test('formatea septiembre correctamente', () {
      expect(formatDate(DateTime(2024, 9, 22)), '22 de sep de 2024');
    });

    test('formatea octubre correctamente', () {
      expect(formatDate(DateTime(2024, 10, 31)), '31 de oct de 2024');
    });

    test('formatea noviembre correctamente', () {
      expect(formatDate(DateTime(2024, 11, 11)), '11 de nov de 2024');
    });

    test('formatea diciembre correctamente', () {
      expect(formatDate(DateTime(2024, 12, 31)), '31 de dic de 2024');
    });

    test('incluye el año correctamente', () {
      expect(formatDate(DateTime(2023, 6, 15)), '15 de jun de 2023');
    });
  });
}
