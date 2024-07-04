import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:travio/controller/utils/theme.dart';

Column tTextfield(
    // ignore: non_constant_identifier_names
    {String? HintText, String? Labeltext, TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$Labeltext',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      TextFormField(
        controller: controller,
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

Column tNumberfield(
    // ignore: non_constant_identifier_names
    {String? HintText, String? Labeltext, TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$Labeltext',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      IntlPhoneField(
        controller: controller,
        initialCountryCode: 'IN',
        decoration: InputDecoration(
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
        onCountryChanged: (phone) {},
      ),
    ],
  );
}

Column tDropdownField(
    {String? labelText,
    String? hintText,
    List<String>? items,
    TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText ?? '',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
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
        items: items?.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller?.text = newValue ?? '';
        },
      ),
    ],
  );
}
