import 'package:e_commerce/models/cart_items.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  double get totalPrice => _items.fold(
      0, (sum, item) => sum + (item.product.offerPrice * item.quantity));

  void addToCart(Product product, [int quantity = 1]) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index] =
          _items[index].copyWith(quantity: _items[index].quantity + quantity);
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
