import 'package:flutter/material.dart';

import 'custom_styles.dart';

class CustomTextFormDecoration {
  static InputDecoration setDecoration(String message) {
    return InputDecoration(
      labelText: message ,
      labelStyle: TextStyle(fontSize: 14),
      hintStyle: TextStyle(fontSize: 14),
      enabledBorder: CustomOutlineInputBorder.custom,
      focusedBorder: CustomOutlineInputBorder.custom,
      errorBorder: CustomOutlineInputBorder.custom,
      focusedErrorBorder: CustomOutlineInputBorder.custom,
    );
  }
}