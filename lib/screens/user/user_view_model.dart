import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/utils/messages.dart';
import 'package:firestore_app/utils/strings.dart';

class UserViewModel {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(Strings.collectionName);

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
}
