import 'package:flutter/material.dart';

ElevatedButton button(
    {required Function fn, required String name, required bool isLoading}) {
  return ElevatedButton(
    onPressed: () {
      fn();
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.purple,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      minimumSize: const Size(double.infinity, 48), // Full-width button
    ),
    child: isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
              strokeWidth: 3,
            ),
          )
        : Text(name),
  );
}
