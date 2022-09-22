import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomBackground{
  static const BoxDecoration setBackground =  BoxDecoration(
      color: Color(0xFF14181B),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('images/background.jpeg'),
      )
  );
}

class CustomText{
  static TextStyle setCustom(FontWeight? fontWeight, double? size, [Color color = Colors.black]){
    return GoogleFonts.overpass(
        textStyle: TextStyle(
          fontWeight: fontWeight,
          fontSize: size,
          color: color,
        )
    );
  }
}