import 'package:firestore_app/models/user_data.dart';
import 'package:firestore_app/screens/home/home.dart';
import 'package:firestore_app/utils/strings.dart';
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
      body: RefreshIndicator(
        onRefresh: getData,
        child: users.isEmpty
            ? const Center(
                child: Text('Empty list'),
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(5),
                    child: listItem(
                      users[index],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          naviagteToUserScreen();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget listItem(UserData userData) {
    return Column(
      children: [
        ListTile(
          trailing: PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(Strings.edit),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(Strings.delete),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'edit') {
                navigateToEdit(userData);
              } else if (value == 'delete') {
                //deleteUI(userData);
                deleteUserById(userData.id);
              }
            },
          ),
          title: Text(
            '${userData.fName!} ${userData.lName!}',
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  userData.city!,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
