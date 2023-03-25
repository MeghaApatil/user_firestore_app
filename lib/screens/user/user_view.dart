import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/user/user_screen.dart';
import 'package:firestore_app/utils/validate_fields.dart';
import 'package:flutter/material.dart';

class UserView extends UserSCreenState {
  @override
  Widget build(BuildContext context) {
    TextEditingController fNameValue = TextEditingController();
    TextEditingController lNameValue = TextEditingController();
    TextEditingController emailValue = TextEditingController();
    TextEditingController cityValue = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add user data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Form(
            key: formKey,
            child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
              child:  Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: fNameValue,
                    validator: validateData,
                    decoration: const InputDecoration(
                        labelText: 'First Name', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: lNameValue,
                    validator: validateData,
                    decoration: const InputDecoration(
                        labelText: 'Last Name', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: emailValue,
                    validator: validateData,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email Id', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: cityValue,
                    validator: validateData,
                    decoration: const InputDecoration(
                        labelText: 'City', border: OutlineInputBorder()),
                  ),
                ),
                ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    UserData userData = UserData(
                        id: '',
                        fName: fNameValue.text,
                        lName: lNameValue.text,
                        email: emailValue.text,
                        city: cityValue.text);
                    submit(userData);
                  },
                )
              ],
            ),),
          ),
        ),
      
    );
  }
}
