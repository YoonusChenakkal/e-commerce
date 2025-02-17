import 'package:e_commerce/common/services/local_storage.dart';
import 'package:e_commerce/common/utils/utils.dart';
import 'package:e_commerce/modules/checkout/repository/checkout_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  bool isLoading = false;
  final _checkoutRepo = CheckoutRepository();

  codCheckout(BuildContext context) async {
    isLoading = true;
    try {
      final userId = await LocalStorage.getUser();

      await _checkoutRepo.codCheckout(userId);
      Utils.flushBar('Order Placed', context);
    } catch (error) {
      if (kDebugMode) {
        print(' fetchUser Error: $error');
      }
      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
