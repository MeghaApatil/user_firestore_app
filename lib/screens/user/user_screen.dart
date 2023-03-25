import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/user/user_view.dart';
import 'package:firestore_app/utils/messages.dart';
import 'package:firestore_app/utils/snackbarutil.dart';
import 'package:firestore_app/utils/strings.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget{
   const UserScreen({super.key});

  @override
  UserView createState() => UserView();
}

abstract class UserSCreenState extends State<UserScreen> {
    final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(Strings.collectionName);
  
  createUser(UserData userData) async {
    final userDoc = userCollection
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .doc();
    userData.id = userDoc.id;
    await userDoc.set(userData).then((value) {
                    Navigator.of(context).popAndPushNamed('/home');
      SnackBarUtil.showSnackbar(Messages.createUser, context);
    }, onError: (e) {
      SnackBarUtil.showSnackbar('Error on creating user data $e', context);
    });
  }
}
