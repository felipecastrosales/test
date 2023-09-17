import 'package:imc/imc.dart';
import 'package:test/test.dart';

void main() {
  setUp(() => null); // before test run
  tearDown(() => null); // after test run
  setUpAll(() => null); // before switch
  tearDownAll(() => null); // after switch

  test('Should calculate IMC', () {
    final result = calcIMC(1.83, 76.0);

    expect(result, equals(22.694018931589476));
  });

  group('Exceptions', () {
    test('Should throw Exception when height is less than 1', () {
      expect(() => calcIMC(0, 80), throwsA(isA<Exception>()));
    });

    test('Should throw Exception when weight is less than 1', () {
      expect(() => calcIMC(1.80, 0), throwsA(isA<Exception>()));
    });
  });
}
