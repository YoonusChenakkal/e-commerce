import 'package:e_commerce/common/services/app_urls.dart';
import 'package:e_commerce/common/services/base_api_services.dart';
import 'package:e_commerce/common/services/network_services.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordRepository {
  final BaseApiServices _apiServices = NetworkServices();

  resetPassword(body) {
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
