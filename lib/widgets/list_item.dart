import 'package:firestore_app/models/user_data.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {

  late UserData userData;

  ListItem({super.key,required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  
                }, icon: const Icon(Icons.edit)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
              ],
            ),
          ),
          title: Text('${userData.fName!} ${userData.lName!}'),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.only(top: 5,bottom: 5),child: Text(userData.email!),),
              Text(userData.city!)],
          ),
        ),
      ],
    );
  }
}
