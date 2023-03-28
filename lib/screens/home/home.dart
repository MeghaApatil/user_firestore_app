import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/home/home_view.dart';
import 'package:firestore_app/screens/home/home_view_model.dart';
import 'package:firestore_app/utils/messages.dart';
import 'package:firestore_app/utils/snackbarutil.dart';
import 'package:firestore_app/utils/strings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeView createState() => HomeView();
}

abstract class HomePageState extends State<Home> {
  @protected
  List<UserData> users = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController fNameValue = TextEditingController();
  TextEditingController lNameValue = TextEditingController();
  TextEditingController emailValue = TextEditingController();
  TextEditingController cityValue = TextEditingController();
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    fNameValue.dispose();
    lNameValue.dispose();
    emailValue.dispose();
    cityValue.dispose();
    super.dispose();
  }

  void updateData(UserData userData) {
    if (formKey.currentState!.validate()) {
      updateUser(userData);
    }
  }

  String? validateData(String? val) {
    if (val == null || val.isEmpty) {
      return 'can\'t be empty';
    } else {
      return null;
    }
  }

  Future<void>getData() async {
    homeViewModel.getdata((List<UserData> usersList) {
      setState(() {
        users = usersList;
      });
    }, (error) {
      SnackBarUtil.showErrorSnackbar(context, error, Colors.red);
    });
  }

  deleteUserById(String id) {
    homeViewModel.deleteUser(id, (success) {
      SnackBarUtil.showSnackbar(success, context);
      Navigator.of(context).popAndPushNamed('/home');
    }, (error) {
      SnackBarUtil.showSnackbar("Error updating document $error", context);
    });
  }

  createUser(UserData userData) {
    homeViewModel.createUser(userData, (success) {
      SnackBarUtil.showSnackbar(success, context);
    }, (error) {
      SnackBarUtil.showSnackbar('Error on creating user data $error', context);
    });
  }

  updateUser(UserData users) {
    UserData userData = UserData(
        id: users.id,
        fName: fNameValue.text.isEmpty ? users.fName : fNameValue.text,
        lName: lNameValue.text.isEmpty ? users.lName : lNameValue.text,
        email: emailValue.text.isEmpty ? users.email : emailValue.text,
        city: cityValue.text.isEmpty ? users.city : cityValue.text);
    homeViewModel.updateUser(userData, users.id, (success) {
      SnackBarUtil.showSnackbar(success, context);
      Navigator.of(context).popAndPushNamed('/home');
    }, (error) {
      SnackBarUtil.showSnackbar('Error on updating user data $error', context);
    });
  }
}
