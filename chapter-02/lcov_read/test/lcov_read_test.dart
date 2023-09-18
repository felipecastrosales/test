import 'package:lcov_read/lcov_read.dart';
import 'package:test/test.dart';

void main() {
  test('Should return coverage', () {
    /// arrange
    final lcovPath = './coverage/lcov.info';

    /// act
    final result = coverage(lcovPath);

    /// assert
    expect(result, isNotEmpty);
    expect(result, '100%');
  });
}
