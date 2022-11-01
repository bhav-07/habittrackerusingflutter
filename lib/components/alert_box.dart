import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  //variables
  final controller;
  final VoidCallback onPressedsave;
  final VoidCallback onPressedcancel;

  const MyAlertBox(
      {super.key,
      required this.onPressedsave,
      required this.onPressedcancel,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            hintText: 'Add/Edit your Habit',
            hintStyle: TextStyle(color: Color.fromARGB(255, 124, 118, 118)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
      actions: [
        MaterialButton(
          onPressed: onPressedsave,
          child: Text(
            "Save",
            style:  TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ),
        MaterialButton(
          onPressed: onPressedcancel,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        )
      ],
    );
  }
}
