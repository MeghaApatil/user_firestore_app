import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/home/home.dart';
import 'package:firestore_app/screens/user/user_view.dart';
import 'package:firestore_app/screens/user/user_view_model.dart';
import 'package:firestore_app/utils/snackbarutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class UserScreen extends StatefulWidget {
  final UserData? userData;
  const UserScreen({super.key, this.userData});

  @override
  UserView createState() => UserView();
}

abstract class UserSCreenState extends State<UserScreen> {
  final formKey = GlobalKey<FormState>();
  UserViewModel userViewModel = UserViewModel();
  bool isEdit = false;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  initState() {
    super.initState();
    checkEditScreen();
  }

  //validate each field
  String? validateData(String? val) {
    if (val == null || val.isEmpty) {
      return 'can\'t be empty';
    } else {
      return null;
    }
  }

  //validation for userdata from home screen
  checkEditScreen() {
    final userData = widget.userData;
    if (widget.userData != null) {
      isEdit = true;
      final fName = userData!.fName;
      final lName = userData.lName;
      final emailId = userData.email;
      final city = userData.city;
      fNameController.text = fName!;
      lNameController.text = lName!;
      emailController.text = emailId!;
      cityController.text = city!;
    }
  }

  //validation for navigation
  checkEditUpdateValidation() {
    if (formKey.currentState!.validate()) {
      isEdit ? updateUser() : submit();
    }
  }

  //create user
  void submit() {
    UserData userData = UserData(
        id: '',
        fName: fNameController.text,
        lName: lNameController.text,
        email: emailController.text,
        city: cityController.text);
    createUser(userData);
  }

  //firestore call for create user
  createUser(UserData userData) {
    userViewModel.createUser(userData, (success) {
      fNameController.text = '';
      lNameController.text = '';
      emailController.text = '';
      cityController.text = '';
      SnackBarUtil.showSnackbar(success, context);
      navigateToHome();
    }, (error) {
      SnackBarUtil.showSnackbar('Error on creating user data $error', context);
    });
  }

  //firestore call for update userdata
  updateUser() {
    final userData = widget.userData;
    if (userData == null) {
      return;
    }
    final id = userData.id;
    UserData userData1 = UserData(
        id: id,
        fName: fNameController.text,
        lName: lNameController.text,
        email: emailController.text,
        city: cityController.text);
    userViewModel.updateUser(userData1, id, (success) {
      SnackBarUtil.showSnackbar(success, context);
      fNameController.text = '';
      lNameController.text = '';
      emailController.text = '';
      cityController.text = '';
      navigateToHome();
    }, (error) {
      SnackBarUtil.showSnackbar('Error on updating user data $error', context);
    });
  }

  navigateToHome() {
    final route = MaterialPageRoute(builder: (context) => const Home());
    Navigator.of(context).push(route);
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
