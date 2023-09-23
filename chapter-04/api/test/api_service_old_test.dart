import 'dart:async';

import 'package:api/api_service.dart';
import 'package:api/product.dart';
import 'package:test/test.dart';
import 'package:uno/uno.dart';

class MockUno implements Uno {
  final bool withError;

  MockUno({this.withError = false});

  @override
  Future<Response> get(
    String url, {
    Duration? timeout,
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    ResponseType responseType = ResponseType.json,
    DownloadCallback? onDownloadProgress,
    ValidateCallback? validateStatus,
  }) async {
    if (withError) {
      throw UnoError('error');
    }

    return Response(
      data: productListJson,
      status: 200,
      headers: headers,
      request: Request(
        uri: Uri.base,
        method: '',
        headers: {},
        timeout: Duration.zero,
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('Should return data from products getter', () async {
    final uno = MockUno();
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
    final uno = MockUno(withError: true);
    final future = ApiService(uno: uno).products;

    expect(future, completes);
    expect(future, completion([]));
  });
}

final productListJson = [
  {'id': 1, 'title': 'title', 'price': 7.0},
  {'id': 7, 'title': 'title', 'price': 7.0},
];
