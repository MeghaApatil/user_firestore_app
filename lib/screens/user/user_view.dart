import 'package:firestore_app/screens/user/user_screen.dart';
import 'package:firestore_app/utils/strings.dart';
import 'package:flutter/material.dart';

class UserView extends UserSCreenState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.addUser),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: fNameController,
                    validator: validateData,
                    decoration: InputDecoration(
                      labelText: Strings.fName,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: lNameController,
                    validator: validateData,
                    decoration: InputDecoration(
                      labelText: Strings.lName,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: emailController,
                    validator: validateData,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: Strings.emailId,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: cityController,
                    validator: validateData,
                    decoration: InputDecoration(
                      labelText: Strings.city,
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text(isEdit ? Strings.update : Strings.submit),
                  onPressed: () {
                    checkEditUpdateValidation();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
