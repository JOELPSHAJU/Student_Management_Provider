import 'package:flutter/material.dart';

const Color primarycolor = Color.fromARGB(255, 82, 10, 116);
const Color secondarycolor = Color.fromARGB(255, 0, 90, 143);

// const Color primarycolor = Color.fromARGB(255, 43, 160, 47);
// const Color secondarycolor = Color.fromARGB(255, 18, 230, 25);

const h1 = SizedBox(
  height: 10,
);
const h2 = SizedBox(
  height: 20,
);

const h3 = SizedBox(
  height: 30,
);

const h4 = SizedBox(
  height: 40,
);
const appbarText =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

decoration({required String label}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primarycolor, width: 2),
      borderRadius: BorderRadius.circular(20),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 4, 113, 7), width: 2),
      borderRadius: BorderRadius.circular(20),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(20),
    ),
    label: Text(label),
  );
}
