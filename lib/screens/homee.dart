import 'package:firestore_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  State<Homee> createState() {
    return HomeState();
  }
}

class HomeState extends State<Homee> {
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.home),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: value1,
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: value2,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dateInput,
              readOnly: true,
              decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: Strings.enterD),
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (dateTime != null) {
                  String formatDate = DateFormat('yyyy-MM-dd').format(dateTime);
                  dateInput.text = formatDate;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
