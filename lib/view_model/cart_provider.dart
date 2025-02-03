import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/repository/cart_repository.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];
  double totalPrice = 0.0;

  final _cartRepository = CartRepository();

  Future<void> fetchCart() async {
    try {
      // Fetch the cart data from the repository
      final response = await _cartRepository.fetchCart();

      // Extract the cart items from the response
      final cartItemsJson = response['cart_items'] as List<dynamic>? ?? [];
      totalPrice = response['total_cart_price'];

      // Map the JSON data to CartItem instances
      final cartItems =
          cartItemsJson.map((json) => CartItem.fromJson(json)).toList();

      // Update the state with the fetched cart items
      this.cartItems = cartItems;

      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Fetch cart error: $e');
      }
      // Optionally, you can rethrow the error or handle it differently
      rethrow;
    }
  }

  Future addToCart(Map<String, dynamic> body, int productId, context) async {
    try {
      final response = await _cartRepository.addToCart(body, productId);
      Utils.flushBar(response['detail'] ?? 'Product added to cart', context,
          color: Colors.green);
      fetchCart();
    } catch (e) {
      if (kDebugMode) {
        print('Add to cart error: $e');
      }
      Utils.flushBar(e.toString(), context);
    }
  }

  Future updateCart(
      Map<String, dynamic> body, int userId, int productId) async {
    try {
      final response =
          await _cartRepository.updateCart(body, userId, productId);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Update cart error: $e');
      }
    }
  }

  Future removeFromCart(int userId, int cartId) async {
    try {
      final response = await _cartRepository.removeFromCart(userId, cartId);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Remove from cart error: $e');
      }
    }
  }

  // List<CartItem> get items => _items;
  // double get totalPrice => _items.fold(
  //     0, (sum, item) => sum + (item.product.offerPrice * item.quantity));

  // void addToCart(Product product, [int quantity = 1]) {
  //   final index = _items.indexWhere((item) => item.product.id == product.id);
  //   if (index >= 0) {
  //     _items[index] =
  //         _items[index].copyWith(quantity: _items[index].quantity + quantity);
  //   } else {
  //     _items.add(CartItem(product: product, quantity: quantity));
  //   }
  //   notifyListeners();
  // }

  // void removeFromCart(int productId) {
  //   _items.removeWhere((item) => item.product.id == productId);
  //   notifyListeners();
  // }

  // void clearCart() {
  //   _items.clear();
  //   notifyListeners();
  // }
}
