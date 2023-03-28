
import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/user/user_view.dart';
import 'package:firestore_app/screens/user/user_view_model.dart';
import 'package:firestore_app/utils/snackbarutil.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  UserView createState() => UserView();
}

abstract class UserSCreenState extends State<UserScreen> {
  final formKey = GlobalKey<FormState>();
  UserViewModel userViewModel = UserViewModel();

  void submit(UserData userData) {
    if (formKey.currentState!.validate()) {
      createUser(userData);
    } else {
      print('elseee');
    }
  }

 String? validateData(String? val) {
    if (val==null||val.isEmpty) {
      return 'can\'t be empty';
    } else {
      return null;
    }
  }
createUser(UserData userData) {
    userViewModel.createUser(userData, (success) {
      SnackBarUtil.showSnackbar(success, context);
    }, (error) {
      SnackBarUtil.showSnackbar('Error on creating user data $error', context);
    });
  }
}
