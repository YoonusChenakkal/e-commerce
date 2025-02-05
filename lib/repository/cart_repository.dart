import 'package:e_commerce/services/app_urls.dart';
import 'package:e_commerce/services/base_api_services.dart';
import 'package:e_commerce/services/network_services.dart';
import 'package:flutter/foundation.dart';

class CartRepository {
  final BaseApiServices _apiServices = NetworkServices();

  Future fetchCart(userId) async {
    // Fetch cart

    try {
      final response = await _apiServices.getApi('$viewCart$userId/');
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Fetch cart error: $e');
      }
    }
  }

  Future addToCart(body, int productId, userId) async {
    // Add product to cart
    try {
      final response =
          _apiServices.postApi('$addToCartUrl$userId/$productId/', body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Add to cart error: $e');
        print('$addToCartUrl$userId/$productId/');
      }
    }
  }

  Future<void> updateCart(body, userId, productId) async {
    // Update product in cart
    try {
      final response =
          _apiServices.patchApi('$updateCartUrl$userId/$productId/', body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Update cart error: $e');
      }
    }
  }

  Future<void> removeFromCart(userId, cartId) async {
    // Remove product from cart
    try {
      final response =
          _apiServices.deleteApi('$removeFromCartUrl$userId/$cartId/');
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Remove from cart error: $e');
      }
    }
  }
}
