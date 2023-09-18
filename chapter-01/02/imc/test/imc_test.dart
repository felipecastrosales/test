import 'package:imc/imc.dart';
import 'package:test/test.dart';

void main() {
  setUp(() => null); // before test run
  tearDown(() => null); // after test run
  setUpAll(() => null); // before switch
  tearDownAll(() => null); // after switch

  test('Should calculate IMC', () {
    /// arrange
    final height = 1.83;
    final weight = 76.0;

    /// act
    final result = calcIMC(height, weight);

    /// assert
    expect(result, equals(22.694018931589476));
    // expect(result, isA<double>());
    // expect(result, greaterThan(20));
    // expect(result, isPositive);
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
