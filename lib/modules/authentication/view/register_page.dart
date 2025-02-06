import 'package:e_commerce/common/routes/routes_name.dart';
import 'package:e_commerce/common/utils/utils.dart';
import 'package:e_commerce/modules/authentication/view_model/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tcName = TextEditingController();
    TextEditingController tcEmail = TextEditingController();
    TextEditingController tcPhone = TextEditingController();
    TextEditingController tcPassword = TextEditingController();
    TextEditingController tcConfirmPassword = TextEditingController();

    final authProvider = Provider.of<AuthProvider>(context);

    // Function to show OTP dialog
    void showOtpDialog(BuildContext context, {required String email}) {
      TextEditingController tcOtp = TextEditingController();
      authProvider.isOtpGenarated = false;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter OTP'),
            content: TextFormField(
              controller: tcOtp,
              decoration: InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter your email OTP.',
              ),
              keyboardType: TextInputType.number,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              Utils.button(
                  isLoading: authProvider.isLoading,
                  text: 'Submit',
                  onPressed: () async {
                    final data = {'email': email, 'otp': tcOtp.text};
                    if (tcOtp.text.isEmpty) {
                      return Utils.flushBar('Enter Otp', context);
                    } else {
                      await authProvider.verifyOtp(data, context);
                    }
                  }),
            ],
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text('Name')),
                controller: tcName,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Email')),
                controller: tcEmail,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Phone')),
                controller: tcPhone,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Password')),
                controller: tcPassword,
                obscureText: true,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Confirm Password')),
                controller: tcConfirmPassword,
                obscureText: true,
              ),
              SizedBox(height: 30),
              Utils.button(
                isLoading: authProvider.isLoading,
                text: 'Register',
                onPressed: () async {
                  final data = {
                    'name': tcName.text,
                    'email': tcEmail.text,
                    'mobile_number': tcPhone.text,
                    'password': tcPassword.text,
                    'confirm_password': tcConfirmPassword.text,
                  };
                  // Call the registration method
                  if (tcName.text.isEmpty ||
                      tcEmail.text.isEmpty ||
                      tcPhone.text.isEmpty ||
                      tcPassword.text.isEmpty ||
                      tcConfirmPassword.text.isEmpty) {
                    Utils.flushBar('Fill all fields', context);
                  } else if (tcPassword.text != tcConfirmPassword.text) {
                    Utils.flushBar('Password does not match', context);
                  } else {
                    await authProvider
                        .userRegister(data, context)
                        .then((value) {
                      if (authProvider.isOtpGenarated) {
                        showOtpDialog(context, email: tcEmail.text);
                      }
                    });
                  }
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RouteName.login);
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
