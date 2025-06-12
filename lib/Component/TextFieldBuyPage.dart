import 'package:flutter/material.dart';

Widget buildInputField(TextEditingController controller, String label) {
  return Container(
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    ),
  );
}