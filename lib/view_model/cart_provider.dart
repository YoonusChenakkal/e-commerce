import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/repository/cart_repository.dart';
import 'package:e_commerce/services/local_storage.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];
  double totalPrice = 0.0;
  bool _canCheckOut = true;
  get canCheckOut => _canCheckOut;
  set canCheckOut(value) {
    _canCheckOut = value;
  }

  final _cartRepository = CartRepository();
  double calculateTotalSavings() {
    return cartItems.fold(0, (sum, item) {
      double originalTotal = item.product.price * item.quantity;
      double discountedTotal = item.price * item.quantity;
      return sum + (originalTotal - discountedTotal);
    });
  }

  Future<void> fetchCart() async {
    try {
      final userId = await LocalStorage.getUser();

      // Fetch the cart data from the repository
      final response = await _cartRepository.fetchCart(userId);

      // Extract the cart items from the response
      final cartItemsJson = response['cart_items'] as List<dynamic>? ?? [];
      totalPrice = response['total_cart_price'];

      // Map the JSON data to CartItem instances
      final cartItems =
          cartItemsJson.map((json) => CartItem.fromJson(json)).toList();

      // Update the state with the fetched cart items
      this.cartItems = cartItems;
      canCheckOut = cartItems.every((item) => item.product.isAvailable);

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
      final userId = await LocalStorage.getUser();

      final response = await _cartRepository.addToCart(body, productId, userId);
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
      Map<String, dynamic> body, int productId, BuildContext context) async {
    try {
      final userId = await LocalStorage.getUser();

      final response =
          await _cartRepository.updateCart(body, userId, productId);
      await fetchCart();
      canCheckOut = cartItems.every((item) => item.product.isAvailable);

      Utils.flushBar('Updated', context, color: Colors.green);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Update cart error: $e');
      }
      Utils.flushBar(e.toString(), context);
    }
  }

  Future removeFromCart(int cartId, BuildContext context) async {
    try {
      final userId = await LocalStorage.getUser();

      await _cartRepository.removeFromCart(userId, cartId);
      fetchCart();
      notifyListeners();
      Utils.flushBar('Item removed', context);
    } catch (e) {
      if (kDebugMode) {
        print('Remove from cart error: $e');
      }
    }
  }
}
