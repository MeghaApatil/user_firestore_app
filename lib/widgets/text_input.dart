import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hint;
  final Icon icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  

  const TextInput(
      {super.key,
      required this.label,
      required this.hint,
      required this.icon,
      required this.controller,
      required this.keyboardType,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: label, hintText: hint, prefixIcon: icon),
          keyboardType: keyboardType),
    );
  }
}
