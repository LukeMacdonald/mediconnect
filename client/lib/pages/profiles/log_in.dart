import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../../utilities/imports.dart';
import 'dart:convert';
import 'dart:io';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  bool _changeEmail = false;
  String? email;

  changeEmailValue(String? newText) {
    setState(() {
      _changeEmail = !_changeEmail;
      email = newText;
    });
  }

  Future login() async {
    var response = await http.post(Uri.parse("${authenticationIP}login"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': await UserSecureStorage.getEmail(),
          'password': await UserSecureStorage.getPassword()
        }));

    var responseData = json.decode(response.body);

    if (responseData['status'] == 401) {
      if (!mounted) return;
      alert("User does not exist", context);
    } else {
      UserSecureStorage.setJWTToken(responseData['access_token']);


      String token = "";
      await UserSecureStorage.getJWTToken().then((value) => token = value!);

      response = await http
          .get(Uri.parse("${authenticationIP}get/${await UserSecureStorage.getEmail()}"), headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: token,
      });
      responseData = json.decode(response.body);

      await UserSecureStorage.setID(responseData['id'].toString());
      await UserSecureStorage.setRole(responseData['role']);

      if (responseData['firstName'] == null) {
        if (!mounted) return;
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: const ProfileCreation())); // Should direct to profile creation page
      } else if (responseData['role'] == "patient") {
        await UserSecureStorage().setDetails(responseData);
        if (!mounted) return;
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const HomePage()));
      } else if (responseData['role'] == "doctor") {
        await UserSecureStorage().setDetails(responseData);
        if (!mounted) return;
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: const DoctorHomePage()));
      } else if (responseData['role'] == "superuser") {
        await UserSecureStorage().setDetails(responseData);

        if (!mounted) return;
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: const AdminHomePage()));
      } else {
        if (!mounted) return;
        alert("Error Logging In", context);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
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
                    //height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
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
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const Landing()));
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
                          const UserGivenPassword(),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SubmitButton(
                                        color: Colors.lightBlueAccent,
                                        message: "Sign in",
                                        width: 225,
                                        height: 50,
                                        onPressed: () {
                                          login();
                                        },
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