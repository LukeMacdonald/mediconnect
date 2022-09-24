import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../styles/background_style.dart';


Widget buttonLanding (Color color,String message,Widget page,BuildContext context){
  return
    Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
          onPressed: () async {
            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: page));
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(230, 50),
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              primary: color),
          child: Text(message,
            style: CustomText.setCustom(FontWeight.w900, 16,Colors.white),
          ),
        ));

}