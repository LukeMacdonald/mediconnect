import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/pages/homepage/home_page.dart';
import 'package:nd_telemedicine/widgets/form_widgets.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';
import '../models/user.dart';
import '../widgets/alerts.dart';
import '../widgets/buttons.dart';
import 'homepage/admin_home.dart';
import 'homepage/doctor_home.dart';
import 'registration/create_profile.dart';
import 'dart:convert';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  User user = User("", "", "","");

  Future login() async {
    var response = await http.post(Uri.parse("${authenticationIP}login"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
        }));
    var responseData = json.decode(response.body);
    print(responseData);

    if (responseData['status'] == 401) {
      if (!mounted) return;
      alert("User does not exist", context);
    } else {
      user.accessToken = responseData['access_token'];

      if (user.accessToken != "") {
        response = await http.get(Uri.parse("${authenticationIP}get/${user.email}"),
            headers: {
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: user.accessToken
            });

        user.setNeededDetails(json.decode(response.body));

        if (user.firstName == "") {
          if (!mounted) return;

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ProfileCreation(
                      user: user))); // Should direct to profile creation page
        } else if (user.role == "patient") {
          user.password = "";
          if (!mounted) return;

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: HomePage(user:user)));
        } else if (user.role == "doctor") {
          user.password = "";
          if (!mounted) return;

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: DoctorHomePage(user:user)));
        } else if (user.role == "superuser") {
          user.password = "";
          if (!mounted) return;
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: AdminHomePage(user:user)));
        } else {
          if (!mounted) return;
          alert("Error Logging In", context);
        }
      }
    }
  }


  bool _changeEmail = false;
  bool _changePassword = false;

  String? email;
  String? password;

  changeEmailValue(String? newText) {
    setState(() {
      _changeEmail = !_changeEmail;
      email = newText;
    });
  }
  changePasswordValue(String? newText) {
    setState(() {
      _changePassword = !_changePassword;
      password = newText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF27C6FF), Color(0xFF2190E5)],
            stops: [0, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(0, 1),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0.05),
              child: Image.asset(
                'images/doctor.jpeg',
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
                    decoration:  BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(130),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.back,
                                size: 40,
                              )),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 5, 0, 0),
                            child: Text(
                              'Welcome Back!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 10),
                            child: Text('Please Enter Your Details Below',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                )),
                          ),
                          UserEmail(changeClassValue: changeEmailValue),
                          UserGivenPassword(changeClassValue: changePasswordValue),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SubmitButton(
                                        color: Colors.blueAccent,
                                        message: "Sign in",
                                        width: 225,
                                        height: 50,
                                        onPressed: (){
                                          user.email = email!;
                                          user.password = password!;
                                          login();
                                          }
                                        ,
                                      ),
                                    ])),
                          )
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
