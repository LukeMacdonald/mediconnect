import 'package:flutter/material.dart';

import 'background_style.dart';
import 'custom_styles.dart';

class CustomTextFormDecoration {
  static InputDecoration setDecoration(String message) {
    return InputDecoration(
      labelText: message ,
      labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
      hintStyle: CustomText.setCustom(FontWeight.w500, 14.0),
      enabledBorder: CustomOutlineInputBorder.custom,
      focusedBorder: CustomOutlineInputBorder.custom,
      errorBorder: CustomOutlineInputBorder.custom,
      focusedErrorBorder: CustomOutlineInputBorder.custom,
    );
  }
}