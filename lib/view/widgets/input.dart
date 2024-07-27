import 'package:flutter/material.dart';

TextFormField textField(
    {required TextEditingController controller,
    required String label,
    required String errorMessage}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
    },
  );
}
