import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    border: InputBorder.none,
    hintText: hintText,
    enabledBorder: InputBorder.none,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: (Colors.lightBlue)),
    ),
  );
}
