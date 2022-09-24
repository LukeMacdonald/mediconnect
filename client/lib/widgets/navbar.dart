import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/user.dart';
import '../pages/dashboard.dart';
import '../pages/landing.dart';

Widget navbar(BuildContext context,Widget page1,Widget page2,Widget page3){
  return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Container(
          width: double.infinity,
          height: 80,
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
              const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
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

Widget navbar2(BuildContext context){
  return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
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
              const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 15, 0, 0),
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ]))));

}

Widget getHomePage(User user){
  if (user.role == "patient"){
    return PatientDashboard(user: user);
  }
  else if(user.role == "doctor"){
    return DoctorDashboard(user: user);
  }
  else if(user.role == "admin"){
    return SuperAdminDashboard(user: user);
  }
  else {
    return const Landing();
  }

}