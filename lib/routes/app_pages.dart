import 'package:firestore_app/routes/app_route.dart';
import 'package:firestore_app/screens/home/home.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Approutes.home,
      page: () => Home(),
    )
  ];
}
