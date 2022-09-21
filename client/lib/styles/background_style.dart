import 'package:flutter/material.dart';
class CustomBackground{
  static const BoxDecoration setBackground =  BoxDecoration(
      color: Color(0xFF14181B),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('images/background.jpeg'),
      )
  );
}