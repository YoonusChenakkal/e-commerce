import 'package:e_commerce/services/app_urls.dart';
import 'package:e_commerce/services/base_api_services.dart';
import 'package:e_commerce/services/network_services.dart';
import 'package:flutter/foundation.dart';

class CheckoutRepository {
  final BaseApiServices _apiServices = NetworkServices();

  Future codCheckout(userId) async {
    try {
      final response =
          await _apiServices.postApi('$codCheckoutUrl$userId/', null);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Add to cart error: $e');
      }
      rethrow;
    }
  }
}
