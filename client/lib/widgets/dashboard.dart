import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget dashboardUserIcon(){
  return Padding(
    padding:
    const EdgeInsetsDirectional.fromSTEB(
        0, 10, 0, 0),
    child: Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
              'images/user.png'),
        ),
      ),
    ),
  );
}

Widget menuOption(Color color, Icon icon,Widget page,String message,BuildContext context){
  return Padding(
    padding:
    const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
    child: Material(
      color: Colors.transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 70,
              color: Theme.of(context).iconTheme.color,
              icon: icon,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: page));
              },
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
  );
}