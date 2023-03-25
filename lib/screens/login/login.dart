
import 'package:firestore_app/screens/login/login_controller.dart';
import 'package:firestore_app/utils/strings.dart';
import 'package:firestore_app/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextInput(
                hint: Strings.enterUsername,
                label: Strings.userName,
                icon: const Icon(Icons.people),
                controller: loginController.usernameValue,
                keyboardType: TextInputType.text),
            TextInput(
              controller: loginController.passwordValue,
              label: Strings.password,
              hint: Strings.enterPassword,
              icon: const Icon(Icons.password_sharp),
              keyboardType: TextInputType.visiblePassword,
            ),
            ElevatedButton(
                onPressed: () {
                  //loginController.nextPage();
                },
                child: Text(Strings.submit))
          ],
        ),
      ),
    );
  }
}
