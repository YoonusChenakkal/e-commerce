import 'package:another_flushbar/flushbar.dart';
import 'package:e_commerce/common/utils/app_style.dart';
import 'package:flutter/material.dart';

class Utils {
  static flushBar(String message, BuildContext context,
      {Color color = Colors.red}) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: color,
      ),
      leftBarIndicatorColor: color,
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3), // Display duration
      flushbarPosition: FlushbarPosition.BOTTOM, // Position: TOP or BOTTOM
      borderRadius: BorderRadius.circular(8.0),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(15.0),
      animationDuration: Duration(milliseconds: 500), // Animation speed
    ).show(context);
  }

  static button({
    required VoidCallback onPressed,
    required String text,
    required bool isLoading,
    Color color = Colors.white,
  }) =>
      ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(color)),
          child: isLoading ? CircularProgressIndicator() : Text(text));

  static tableRow({required String label, required String? value}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '$label : ',
            style: headline3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            value ?? 'Not set',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
