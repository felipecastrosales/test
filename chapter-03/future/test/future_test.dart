import 'package:future/future.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the list', () async {
    final future = futureList;
    expect(future, completes);
    expect(futureList, completes);
    expect(futureList, completion(isA<List<String>>()));
    expect(futureList, completion(equals(['felipe', '7'])));
  });
}
