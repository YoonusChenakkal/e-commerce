import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view_model/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context);

    TextEditingController tcEmail =
        TextEditingController(text: changePasswordProvider.email);
    TextEditingController tcOtp = TextEditingController();

    TextEditingController tcPassword = TextEditingController();
    TextEditingController tcConfirmPassword = TextEditingController();

    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) => changePasswordProvider.reset(),
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Email')),
            enabled: changePasswordProvider.resetSuccess ? false : true,
            controller: tcEmail,
          ),
          if (changePasswordProvider.resetSuccess)
            TextFormField(
              decoration: InputDecoration(label: Text('Otp')),
              controller: tcOtp,
            ),
          if (changePasswordProvider.isOtpSuccess) ...[
            TextFormField(
              decoration: InputDecoration(label: Text('Password')),
              controller: tcPassword,
            ),
            TextFormField(
              decoration: InputDecoration(label: Text('Confirm Password')),
              controller: tcConfirmPassword,
            ),
          ],
          SizedBox(
            height: 30,
          ),
          Utils.button(
            isLoading: changePasswordProvider.isLoading,
            text: changePasswordProvider.isOtpSuccess
                ? 'Change Password'
                : 'Submit',
            onPressed: () {
              if (changePasswordProvider.isOtpSuccess) {
                // Case 1: Change password after OTP is verified
                if (tcEmail.text.isEmpty ||
                    tcPassword.text.isEmpty ||
                    tcConfirmPassword.text.isEmpty) {
                  Utils.flushBar('Please fill all fields', context);
                  return;
                }

                if (tcPassword.text != tcConfirmPassword.text) {
                  Utils.flushBar('Passwords do not match', context);
                  return;
                }

                final data = {
                  'email': tcEmail.text.trim(),
                  'new_password': tcPassword.text.trim(),
                  'confirm_new_password': tcConfirmPassword.text.trim()
                };
                changePasswordProvider.changePassword(data, context);
              } else if (changePasswordProvider.resetSuccess) {
                // Case 2: Validate OTP
                if (tcOtp.text.isEmpty) {
                  Utils.flushBar('Please enter OTP', context);
                  return;
                }

                final data = {
                  'email': tcEmail.text.trim(),
                  'otp': tcOtp.text.trim(),
                };
                changePasswordProvider.otpValidation(data, context);
              } else {
                // Case 3: Request password reset
                if (tcEmail.text.isEmpty) {
                  Utils.flushBar('Please enter email', context);
                  return;
                }

                final data = {'email': tcEmail.text.trim()};
                changePasswordProvider.email = tcEmail.text;
                changePasswordProvider.resetPassword(data, context);
              }
            },
          ),
        ]),
      ),
    );
  }
}
