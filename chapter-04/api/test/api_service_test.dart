import 'package:api/api_service.dart';
import 'package:api/product.dart';
import 'package:test/test.dart';
import 'package:uno/uno.dart';

void main() {
  test('Should return data from products getter', () async {
    final uno = Uno();
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
    final uno = Uno();
    final future = ApiService(uno: uno).products;

    expect(future, completes);
    expect(future, completion([]));
  });
}
