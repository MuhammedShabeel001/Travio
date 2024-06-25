import 'package:flutter/material.dart';

Container tWelcome(String? welcome) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10,left: 20),
    width: double.infinity,
    child:  Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$welcome',
          style: const TextStyle(
            fontSize: 19,
            color: Color.fromARGB(153, 255, 255, 255),
          ),
        ),
        const Text(
          'travio',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1,
          ),
        ),
      ],
    ),
  );
}
