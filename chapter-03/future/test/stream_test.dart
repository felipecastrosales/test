import 'package:future/stream.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the list - stream', () async {
    final stream = streamList;
    expect(stream, emits('felipe'));
    expect(stream, emitsInOrder(['felipe', '07']));
  });
}
