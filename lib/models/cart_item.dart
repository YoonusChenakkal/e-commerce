import 'package:e_commerce/models/product_model.dart';

class CartItem {
  final int id;
  final String user;
  final Product product;
  final int quantity;
  final String selectedWeight;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItem({
    required this.id,
    required this.user,
    required this.product,
    required this.quantity,
    required this.selectedWeight,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: _parseInt(json["id"]),
      user: json["user"],
      product: Product.fromJson(json["product"]),
      quantity: _parseInt(json["quantity"]),
      selectedWeight: json["selected_weight"] ?? "",
      price: _parseDouble(json["price"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is num) return value.toDouble();
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}
