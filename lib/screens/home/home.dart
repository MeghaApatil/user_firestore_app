import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/home/home_view.dart';
import 'package:firestore_app/screens/home/home_view_model.dart';
import 'package:firestore_app/screens/user/user_screen.dart';
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
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    getData();
  }
  //validation for fields
  String? validateData(String? val) {
    if (val == null || val.isEmpty) {
      return 'can\'t be empty';
    } else {
      return null;
    }
  }
  //firestore call to get user list
  Future<void> getData() async {
    homeViewModel.getdata((List<UserData> usersList) {
      setState(() {
        users = usersList;
      });
    }, (error) {
      SnackBarUtil.showErrorSnackbar(context, error, Colors.red);
    });
  }
  //firestore call for delete selected user
  deleteUserById(String id) {
    homeViewModel.deleteUser(id, (success) {
      SnackBarUtil.showSnackbar(success, context);
      navigateToHome();
    }, (error) {
      SnackBarUtil.showSnackbar("Error updating document $error", context);
    });
  }


  navigateToEdit(UserData userData1) {
    final route = MaterialPageRoute(
      builder: (context) => UserScreen(
        userData: userData1,
      ),
    );
    Navigator.of(context).push(route);
  }

  naviagteToUserScreen() {
    final route = MaterialPageRoute(builder: (context) => const UserScreen());
    Navigator.of(context).push(route);
  }

  navigateToHome() {
    final route = MaterialPageRoute(builder: (context) => const Home());
    Navigator.of(context).push(route);
  }

}
