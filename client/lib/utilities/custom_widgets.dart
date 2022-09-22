import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../dashboard.dart';
import '../styles/background_style.dart';

Future<String?> alert(String message,BuildContext context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text(message), actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ]));
}

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
Widget pad(double left, double top, double right, double bottom){
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(left, top, right, left),
  );
}
Widget menuButtons(Color color,Text message, Icon icons,BuildContext context, MaterialPageRoute page){

  return Padding(
      padding:
      const EdgeInsetsDirectional.fromSTEB(
          0, 20, 0, 20),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              page
          );
        },
        label: message,
        icon: icons,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(8)),
          fixedSize: const Size(260, 70),
          side: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          textStyle: GoogleFonts.lexendDeca(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      )
  );
}
Widget dashboardUserIcon(){
  return Padding(
    padding:
    const EdgeInsetsDirectional.fromSTEB(
        0, 10, 0, 0),
    child: Container(
      width: 120,
      height: 120,
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
Widget dashboardNavbar(){
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        icon: const Icon(
          Icons.notifications,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          print('Notifications pressed ...');
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          print('Settings pressed ...');
        },
      ),
    ],
  );
}
Widget welcomeMessage(String name){
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(
        10, 20, 10, 0),
    child: Text(
        'Welcome Back $name',
        style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30)),
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
              color: const Color(0x00F77173),
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
                style: CustomText.setCustom(
                    FontWeight.bold, 18, Colors.white)),
          ],
        ),
      ),
    ),
  );
}

Widget navbar(BuildContext context,Widget page1,Widget page2,Widget page3){
  return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Container(
          width: double.infinity,
          height: 105,
          decoration: const BoxDecoration(
            color: Color(0xFF2190E5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(1000),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          child: Padding(
              padding:
              const EdgeInsetsDirectional.fromSTEB(10, 25, 0, 0),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 10, 0, 0),
                      child: IconButton(
                        iconSize: 60,
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: page1));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 10, 0, 0),
                      child: IconButton(
                        iconSize: 60,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: page2));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 10, 0, 0),
                      child: IconButton(
                        iconSize: 60,
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: page3));
                        },
                      ),
                    ),
                  ]))));

}