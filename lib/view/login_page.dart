import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view_model/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tcEmail = TextEditingController();
    TextEditingController tcPassword = TextEditingController();

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Email')),
            controller: tcEmail,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('Password')),
            controller: tcPassword,
          ),
          SizedBox(
            height: 30,
          ),
          Utils.button(
              onPressed: () {
                final data = {
                  'email': tcEmail.text,
                  'password': tcPassword.text
                };
                if (tcEmail.text.isEmpty || tcPassword.text.isEmpty) {
                  Utils.flushBar('Please fill all fields', context);
                } else {
                  authProvider.userLogin(data, context);
                }
              },
              text: 'Login',
              isLoading: authProvider.isLoading),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?'),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteName.register);
                  },
                  child: Text('Register'))
            ],
          )
        ],
      ),
    );
  }
}
