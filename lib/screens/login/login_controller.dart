import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController usernameValue = TextEditingController();
  TextEditingController passwordValue = TextEditingController();

  void nextPage() {
    Get.toNamed('/home');
  }
}
