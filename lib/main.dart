import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_app/screens/home/home.dart';
import 'package:firestore_app/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Home(),
      routes: {
        '/home': (context) => Home(),
        '/user': (context) => UserScreen(),
  });
  }
}

