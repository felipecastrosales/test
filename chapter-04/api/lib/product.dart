import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  final int id;
  final String title;
  final double price;

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as double,
    );
  }

  @override
  List<Object?> get props => [id, title, price];
}
