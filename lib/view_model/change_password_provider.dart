import 'package:e_commerce/repository/change_password_repository.dart';
import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool isLoading = false;
  bool resetSuccess = false;
  bool isOtpSuccess = false;
  bool passwordChangeSuccess = false;
  String? email;

  final _authRepo = ChangePasswordRepository();

  reset() {
    isLoading = false;
    resetSuccess = false;
    isOtpSuccess = false;
    email = null;
  }

  Future<void> resetPassword(
      Map<String, dynamic> body, BuildContext context) async {
    isLoading = true;

    notifyListeners();

    try {
      final response = await _authRepo.resetPassword(body);

      resetSuccess = response['status'];
      notifyListeners();
      Utils.flushBar(response['detail'], context, color: Colors.blue);
    } catch (error) {
      if (kDebugMode) {
        print('userLogin Error: $error');
      }

      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  otpValidation(Map<String, dynamic> body, BuildContext context) async {
    isLoading = true;
    resetSuccess = false;
    notifyListeners();

    try {
      final response = await _authRepo.otpValidation(body);

      isOtpSuccess = response['status'];
      notifyListeners();

      Utils.flushBar(response['detail'], context, color: Colors.blue);
    } catch (error) {
      if (kDebugMode) {
        print('userRegister Error: $error');
      }

      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  changePassword(Map<String, dynamic> body, BuildContext context) async {
    isLoading = true;
    isOtpSuccess = false;
    notifyListeners();

    try {
      final response = await _authRepo.changePassword(body);
      reset();
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.login,
        (route) => false,
      );
      await Utils.flushBar(response['detail'], context, color: Colors.blue);
    } catch (error) {
      if (kDebugMode) {
        print('userRegister Error: $error');
      }

      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
