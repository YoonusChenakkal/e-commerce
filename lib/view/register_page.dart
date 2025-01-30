import 'package:e_commerce/utils/utils.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tcEmail = TextEditingController();
    TextEditingController tcPhone = TextEditingController();
    TextEditingController tcPassword = TextEditingController();
    TextEditingController tcConfirmPassword = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Email')),
            controller: tcEmail,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('phone')),
            controller: tcPhone,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('Password')),
            controller: tcPassword,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('confirm Password')),
            controller: tcConfirmPassword,
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Utils.flushBar(' HI', context);
              },
              child: Text('Register'))
        ],
      ),
    );
  }
}
