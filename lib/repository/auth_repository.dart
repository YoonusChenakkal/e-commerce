import 'package:e_commerce/services/app_urls.dart';
import 'package:e_commerce/services/base_api_services.dart';
import 'package:e_commerce/services/network_services.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkServices();

  userLogin(body) {
    try {
      final response = _apiServices.postApi(loginUrl, body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('user Login : $e');
      }
    }
  }

  userRegister(body) {
    try {
      final response = _apiServices.postApi(registerUrl, body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(registerUrl);
        print('user Register : $e');
      }
    }
  }

  verifyOtp(body) {
    try {
      final response = _apiServices.postApi(verifyOtpUrl, body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('verify Otp : $e');
      }
    }
  }
}
