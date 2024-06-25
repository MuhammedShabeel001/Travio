import 'package:flutter/material.dart';
import 'package:travio/utils/theme.dart';

Column tTextfield({String? HintText,String? Labeltext}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    
    children: [
      Text('${Labeltext}',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),),
      TextFormField(
        decoration: InputDecoration(
          hintText: HintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(101, 0, 0, 0),
          ),
          fillColor: TTthemeClass().ttThirdOpacity,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
        ),
      ),
    ],
  );
}
