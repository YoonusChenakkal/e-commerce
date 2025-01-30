import 'package:e_commerce/models/user_model.dart';
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
        print('user Register : $e');
      }
    }
  }

  Future<UserModel> fetchUser(userId) async {
    userId = 39;
    try {
      final response = await _apiServices.getApi('$fetchUserUrl$userId/');

      return UserModel.fromJson(response); 
    } catch (e) {
      if (kDebugMode) {
        print('fetchUser Error: $e');
      }
      rethrow;
    }
  }
}
