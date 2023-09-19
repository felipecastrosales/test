import 'package:lcov_read/lcov_read.dart';
import 'package:lcov_read/line_report.dart';
import 'package:test/test.dart';

void main() {
  test('Should return coverage with 100%', () {
    /// arrange
    final lcovPath = './coverage/lcov.info';

    /// act
    final result = coverage(lcovPath);

    /// assert
    expect(result, isNotEmpty);
    expect(result, '100%');
  });

  test('Should return coverage with 50%', () {
    final result = calculatePercent([
      LineReport(sourceFile: '', lineFound: 70, lineHit: 35),
      LineReport(sourceFile: '', lineFound: 10, lineHit: 5),
    ]);

    expect(result, 50);
  });
}
