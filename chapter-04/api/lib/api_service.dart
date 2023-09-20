import 'package:api/product.dart';
import 'package:uno/uno.dart';

class ApiService {
  ApiService({
    required Uno uno,
  }) : _uno = uno;

  final Uno _uno;

  Future<List<Product>> getProducts() async {
    try {
      final response = await _uno.get('/product');
      final list = response.data as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on UnoError {
      return [];
    }
  }
}
