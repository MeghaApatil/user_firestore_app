import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/home/home_view.dart';
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

  @override
  void initState() {
    super.initState();
    getdata();
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
    if (val==null||val.isEmpty) {
      return 'can\'t be empty';
    } else {
      return null;
    }
  }
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(Strings.collectionName);

  Future<List<UserData>> getdata() async {
    final ref = userCollection.withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData city, _) => city.toFirestore(),
    );
    final docSnap = await ref.get();
    final city = docSnap.docs; // Convert to City object list
    if (city != null) {
      city.forEach((element) async {
        setState(() {
          users.add(element.data());
        });
      });
    } else {
      // FToast().showToast(Messages.listEmpty);
      SnackBarUtil.showSnackbar(Messages.listEmpty, context);
    }
    return users;
  }

  deleteUser(String id) {
    userCollection.doc(id).delete().then(
      (doc) {
        SnackBarUtil.showSnackbar(Messages.deleteUser, context);
        Navigator.of(context).popAndPushNamed('/home');
      },
      onError: (e) {
        SnackBarUtil.showSnackbar("Error updating document $e", context);
      },
    );
  }

  updateUser(UserData users) {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(Strings.collectionName);
    UserData userData = UserData(
        id: users.id,
        fName: fNameValue.text.isEmpty ? users.fName : fNameValue.text,
        lName: lNameValue.text.isEmpty ? users.lName : lNameValue.text,
        email: emailValue.text.isEmpty ? users.email : emailValue.text,
        city: cityValue.text.isEmpty ? users.city : cityValue.text);

    userCollection.doc(users.id).update(userData.toFirestore()).then((value) {
      SnackBarUtil.showSnackbar(Messages.updateUser, context);
      Navigator.of(context).popAndPushNamed('/home');
    }, onError: (e) {
      SnackBarUtil.showSnackbar('Error on updating user data $e', context);
    });
  }

  createUser(UserData userData) async {
    final userDoc = userCollection
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .doc();
    userData.id = userDoc.id;
    await userDoc.set(userData).then((value) {
      SnackBarUtil.showSnackbar(Messages.createUser, context);
    }, onError: (e) {
      SnackBarUtil.showSnackbar('Error on creating user data $e', context);
    });
  }
}
