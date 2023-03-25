import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/home/home.dart';
import 'package:firestore_app/utils/strings.dart';
import 'package:firestore_app/utils/validate_fields.dart';
import 'package:flutter/material.dart';

class HomeView extends HomePageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.home),
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
        children: [
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.all(5),
                    child: listItem(
                      users[index],
                    ));
              })
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //addUserPopup();
          Navigator.of(context).pushNamed('/user');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget listItem(UserData userData) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person_4),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      showEditUI(userData);
                      // Navigator.of(context).popAndPushNamed('/userUpdate');
                      // MaterialPageRoute(builder: (context) => UserUpdateView(userData: userData,));
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      deleteUI(userData);
                      //deleteUser(userData.id);
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
          ),
          title: Text(
            '${userData.fName!} ${userData.lName!}',
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(userData.email!,
                    style: const TextStyle(color: Colors.black, fontSize: 15)),
              ),
              Text(userData.city!,
                  style: const TextStyle(color: Colors.black, fontSize: 15))
            ],
          ),
        ),
      ],
    );
  }

  Future showEditUI(UserData userData) {
    fNameValue.text = userData.fName!;
    lNameValue.text = userData.lName!;
    emailValue.text = userData.email!;
    cityValue.text = userData.city!;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          // title: Text(Strings.updateUSer),
          content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: fNameValue,
                      validator: validateData,
                      decoration: InputDecoration(
                        labelText: Strings.fName,
                      ),
                    ),
                    TextFormField(
                      controller: lNameValue,
                      validator:validateData,
                      decoration: InputDecoration(
                        labelText: Strings.lName,
                      ),
                    ),
                    TextFormField(
                      controller: emailValue,
                      validator: validateData,
                      decoration: InputDecoration(
                        labelText: Strings.emailId,
                      ),
                    ),
                    TextFormField(
                      controller: cityValue,
                      validator: validateData,
                      decoration: InputDecoration(
                        labelText: Strings.city,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            updateData(userData);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                          child: Text(Strings.update),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            child: Text(Strings.cancel))
                      ],
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Future addUserPopup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(Strings.addUser),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      decoration: const InputDecoration(
                        labelText: 'Email Id',
                      ),
                    ),
                    TextFormField(
                      controller: cityValue,
                      decoration: const InputDecoration(
                        labelText: 'City',
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text(Strings.submit),
                  onPressed: () {
                    UserData userData = UserData(
                        id: '',
                        fName: fNameValue.text,
                        lName: lNameValue.text,
                        email: emailValue.text,
                        city: cityValue.text);
                    setState(() {
                      createUser(userData);
                      Navigator.of(context).pop();
                    });
                  })
            ],
          );
        });
  }

  Future deleteUI(UserData userData) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(Strings.delteUser),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: const [
                    Text('Are you sure want to delete this user?')
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text(Strings.delete),
                  onPressed: () {
                    setState(() {
                      deleteUser(userData.id);
                      Navigator.of(context).pop();
                    });
                  }),
              TextButton(
                  child: Text(Strings.cancel),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  })
            ],
          );
        });
  }
}
