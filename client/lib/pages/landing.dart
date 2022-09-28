import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'registration/register.dart';
import '../widgets/buttons.dart';
import 'log_in.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _Landing();
}

class _Landing extends State<Landing> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF27C6FF), Color(0xFF2190E5)],
            stops: [0, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(0, 1),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0.05),
                child: Image.asset(
                  'images/doctor.jpeg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.elliptical(90, 100),
                          topRight: Radius.elliptical(90, 150)),
                      elevation: 50,
                      child: Container(
                        width: double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                              topLeft: Radius.elliptical(90, 100),
                              topRight: Radius.elliptical(90, 100)
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 50, 0, 0),
                              child: Text('For a better health!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 30)
                                  //CustomText.setCustom(FontWeight.w800, 30.0),
                                  ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                              child: Text(
                                  'Keeping Yourself Healthy Has Never Been Easier!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                            SubmitButton(
                              color: Colors.blueAccent,
                              message: "Sign In",
                              width: 225,
                              height: 50,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const LogIn()));
                              },
                            ),
                            const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text(
                                    'Dont Have an Account? Sign Up Below',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                            SubmitButton(
                                color: Colors.teal,
                                message: "Create Account",
                                width: 225,
                                height: 50,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const Register()));
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
