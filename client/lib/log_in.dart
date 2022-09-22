import 'package:client/styles/background_style.dart';
import 'package:client/styles/custom_styles.dart';
import 'package:client/utilities/custom_widgets.dart';
import 'package:client/utilities/user.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:client/utilities/custom_functions.dart';
import 'package:client/create_profile.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import "dashboard.dart";
import 'dart:convert';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  User user = User("", "", "");

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late bool passwordVisibility;

  Future login() async {
    var response = await http.post(Uri.parse("${url()}login"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
        }));
    var responseData = json.decode(response.body);

    if (responseData['status'] == 401) {
      if (!mounted) return;
      alert("User does not exist", context);
    } else {
      user.token = responseData['access_token'];

      if (user.token != "") {
        response = await http.get(Uri.parse("${url}user/get/${user.email}"),
            headers: {
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: user.token
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
        } else if (user.role == "Patient") {
          user.password = "";
          if (!mounted) return;

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: PatientDashboard(user: user)));
        } else if (user.role == "Doctor") {
          user.password = "";
          if (!mounted) return;

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: DoctorDashboard(user: user)));
        } else if (user.role == "Admin") {
          user.password = "";
          if (!mounted) return;
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: SuperAdminDashboard(user: user)));
        } else {
          if (!mounted) return;
          alert("Error Logging In", context);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  Widget password() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: CustomText.setCustom(FontWeight.w500, 14),
                      hintText: 'Enter Password',
                      hintStyle: CustomText.setCustom(FontWeight.w500, 14),
                      enabledBorder: CustomOutlineInputBorder.custom,
                      focusedBorder: CustomOutlineInputBorder.custom,
                      errorBorder: CustomOutlineInputBorder.custom,
                      focusedErrorBorder: CustomOutlineInputBorder.custom,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      )),
                  style: CustomText.setCustom(FontWeight.w500, 14),
                )))
      ],
    );
  }

  Widget email() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: CustomText.setCustom(FontWeight.w500, 14),
                    hintText: 'Enter your email address...',
                    hintStyle: CustomText.setCustom(FontWeight.w500, 14),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: CustomText.setCustom(FontWeight.w500, 14),
                  keyboardType: TextInputType.emailAddress,
                )))
      ],
    );
  }

  Widget buttonLogIn() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  user.email = emailController.text,
                  user.password = passwordController.text,
                  login(),
                },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color(0xFF6CC987)),
            child: Text(
              'Sign In',
              style: CustomText.setCustom(FontWeight.w900, 16, Colors.white),
            )));
  }

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
                                  Icons.arrow_back_ios,
                                  size: 30,
                                  color: Colors.black,
                                )),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'Welcome Back!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Overpass',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 5, 0, 5),
                              child: Text('Please Enter Your Details Below',
                                  style: TextStyle(
                                    fontFamily: 'Overpass',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  )),
                            ),
                            email(),
                            password(),
                            pad(0, 5, 0, 0),
                            Container(
                                width: double.infinity,
                                height: 90,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      buttonLogIn(),
                                    ]))
                          ]),
                    )
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
