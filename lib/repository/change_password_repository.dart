import 'package:e_commerce/services/base_api_services.dart';
import 'package:e_commerce/services/network_services.dart';
import 'package:e_commerce/services/app_urls.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordRepository {
  resetPassword(body) {
    final BaseApiServices _apiServices = NetworkServices();

    try {
      final response = _apiServices.postApi(passwordResetUrl, body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('user Login : $e');
      }
    }
  }

  otpValidation(body) {
    final BaseApiServices _apiServices = NetworkServices();

    try {
      final response = _apiServices.postApi(passwordOtpUrl, body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('user Login : $e');
      }
    }
  }

  changePassword(body) {
    final BaseApiServices _apiServices = NetworkServices();

    try {
      final response = _apiServices.postApi(passwordChangeUrl, body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('user Login : $e');
      }
    }
  }
}
