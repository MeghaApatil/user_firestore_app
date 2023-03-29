import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/utils/messages.dart';
import 'package:firestore_app/utils/strings.dart';
import 'package:flutter/material.dart';

class HomeViewModel {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(Strings.collectionName);

  Future<List<UserData>> getdata(Function completion, Function error) async {
    final ref = userCollection.withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData city, _) => city.toFirestore(),
    );
    List<UserData> users = [];
    final docSnap = await ref.get();
    final city = docSnap.docs; // Convert to City object list
    if (city != null) {
      city.forEach((element) async {
        users.add(element.data());
      });
      completion(users);
    } else {
      error(Messages.listEmpty);
    }
    return users;
  }

  createUser(UserData userData, Function completion, Function error) async {
    final userDoc = userCollection
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .doc();
    userData.id = userDoc.id;
    await userDoc.set(userData).then((value) {
      completion(Messages.createUser);
    }, onError: (e) {
      error(e);
    });
  }


  deleteUser(String id, Function completion, Function error) {
    userCollection.doc(id).delete().then(
      (doc) {
        completion(Messages.deleteUser);
      },
      onError: (e) {
        error(e);
      },
    );
  }
}
