import 'package:flutter/material.dart';

class SnackBarUtil{
 static showSnackbar(String message,BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}