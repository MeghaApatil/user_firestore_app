import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  final Widget title;

  const AppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
    );
  }
}
