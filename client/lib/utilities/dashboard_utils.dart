import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        0, 20, 0, 0),
    child: Container(
      width: 120,
      height: 120,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
              'images/user_icon.png'),
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