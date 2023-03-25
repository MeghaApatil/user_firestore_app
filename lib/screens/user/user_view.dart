import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/user/user_screen.dart';
import 'package:flutter/material.dart';

class UserView extends UserSCreenState{
  
  @override
  Widget build(BuildContext context) {
    
  TextEditingController fNameValue = TextEditingController();
  TextEditingController lNameValue = TextEditingController();
  TextEditingController emailValue = TextEditingController();
  TextEditingController cityValue = TextEditingController();

    return Scaffold(
      appBar: AppBar(title:const Text('Add user data'),),
      body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: fNameValue,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      controller: lNameValue,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    TextFormField(
                      controller: emailValue,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Id',
                      ),
                    ),
                    TextFormField(
                      controller: cityValue,
                      decoration: const InputDecoration(
                        labelText: 'City',
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
                    createUser(userData);
                    
                  })
                  ],
                ),
              ),
              )
            ),
    );
  }
  

}