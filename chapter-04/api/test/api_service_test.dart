import 'package:api/api_service.dart';
import 'package:api/product.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:uno/uno.dart';

class MockUno extends Mock implements Uno {}

class MockResponse extends Mock implements Response {}

void main() {
  final uno = MockUno();

  tearDown(() {
    reset(uno);
  });

  test('Should return data from products getter', () async {
    final response = MockResponse();

    when(() => response.data).thenReturn(productListJson);
    when(() => uno.get(any())).thenAnswer((_) async => response);

    final future = ApiService(uno: uno).products;

    expect(future, completes);
    expect(
      future,
      completion([
        Product(id: 1, title: 'title', price: 7),
        Product(id: 7, title: 'title', price: 7),
      ]),
    );
  });

  test('Should return empty list from products getter when has error',
      () async {
    final response = MockResponse();
    when(() => response.data).thenReturn(productListJson);
    when(() => uno.get(any())).thenThrow(UnoError('error'));

    final future = ApiService(uno: uno).products;

    expect(future, completes);
    expect(future, completion([]));
  });
}

final productListJson = [
  {'id': 1, 'title': 'title', 'price': 7.0},
  {'id': 7, 'title': 'title', 'price': 7.0},
];
