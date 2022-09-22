import 'package:client/log_in.dart';
import 'package:client/register.dart';
import 'package:client/styles/background_style.dart';
import 'package:client/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
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
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(130),
                          topRight: Radius.circular(130),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 50, 0, 0),
                            child: Text(
                              'For a better health!',
                              textAlign: TextAlign.center,
                              style:
                                  CustomText.setCustom(FontWeight.w800, 30.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: Text(
                              'Keeping Yourself Healthy Has Never Been Easier!',
                              style:
                                  CustomText.setCustom(FontWeight.w500, 14.0),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                          buttonLanding(const Color(0xFF6CC987), "Sign In",
                              const LogIn(), context),
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Text(
                                'Dont Have an Account? Sign Up Below',
                                style:
                                    CustomText.setCustom(FontWeight.w500, 14.0),
                              )),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                          buttonLanding(const Color(0xFF2190E5),
                              "Create Account", const Register(), context)
                        ],
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
