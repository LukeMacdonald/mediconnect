import 'dart:convert';

import 'package:client/create_profile.dart';
import 'package:client/dashboard.dart';
import 'package:client/styles/background_style.dart';
import 'package:client/styles/custom_styles.dart';
import 'package:client/utilities/custom_functions.dart';
import 'package:client/utilities/custom_widgets.dart';
import 'package:client/utilities/user.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  late bool passwordVisibility;

  late TextEditingController passwordConfirmController;

  late bool passwordConfirmVisibility;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late String role;

  late User user;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();

    user = User("", "", "");

    passwordController = TextEditingController();
    passwordVisibility = false;

    passwordConfirmController = TextEditingController();
    passwordConfirmVisibility = false;

    role = "";
  }

  Widget buttonRegister(
      Color color, String message, Widget page, BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
              constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
              child: ElevatedButton(
                  onPressed: () async {
                    if (role == "Patient") {
                      user = User(
                          emailController.text, passwordController.text, role);
                      save();
                    } else if (role == "Doctor") {
                      user = User(
                          emailController.text, passwordController.text, role);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Verification(
                                user: user,
                              )));
                    } else {
                      alert("Role Not Selected!", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(230, 50),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: color),
                  child: Text(message,
                      style: CustomText.setCustom(FontWeight.w900, 16, Colors.white),
                      )))
        ]));
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
                      labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                      hintText: 'Enter Password',
                      hintStyle: CustomText.setCustom(FontWeight.w500, 14.0),
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
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
                )))
      ],
    );
  }

  Widget confirmPassword() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                child: TextFormField(
                  controller: passwordConfirmController,
                  obscureText: !passwordConfirmVisibility,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                      hintText: 'Enter Password',
                      hintStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                      enabledBorder: CustomOutlineInputBorder.custom,
                      focusedBorder: CustomOutlineInputBorder.custom,
                      errorBorder: CustomOutlineInputBorder.custom,
                      focusedErrorBorder: CustomOutlineInputBorder.custom,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => passwordConfirmVisibility =
                              !passwordConfirmVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordConfirmVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      )),
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
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
                    labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                    hintText: 'Enter your email address...',
                    hintStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
                  keyboardType: TextInputType.emailAddress,
                )))
      ],
    );
  }

  Widget userRole() {
    return CustomRadioButton(
      spacing: 50,
      buttonLables: const ['Doctor', 'Patient'],
      buttonValues: const ['Doctor', 'Patient'],
      radioButtonValue: (value) {
        role = value as String;
      },
      enableButtonWrap: true,
      elevation: 5,
      autoWidth: true,
      enableShape: true,
      unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
      selectedBorderColor: const Color(0xFF2190E5),
      unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
      selectedColor: const Color(0xFF2190E5),
      padding: 5,
    );
  }

  Future save() async {
    final response = await http.post(Uri.parse("${url()}register"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'role': user.role
        }));
    var responseData = json.decode(response.body);

    if (responseData['message'] != null) {
      if (!mounted) return;
      alert(responseData['message'], context);
    }
    else {
      user.setNeededDetails(responseData);
      if (!mounted) return;
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: ProfileCreation(user: user)
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF2190E5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(1000),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.black,
                      )),
                ]),
              )),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Register',
                  style: CustomText.setCustom(FontWeight.w800, 30,const Color(0xFF2190E5)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 0, 5),
            child: Text(
              'Create an account below, by entering your information.',
              style: CustomText.setCustom(FontWeight.w500, 14),
            ),
          ),
          email(),
          password(),
          confirmPassword(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What Are You Registering as:',
                        style: CustomText.setCustom(FontWeight.w500, 14),
                      ),
                    ]),
              ),
            ),
          ),
          pad(20, 0, 0, 15),
          userRole(),
          pad(20, 0, 0, 35),
          buttonRegister(const Color(0xFF2190E5), "Create Account",
              DoctorDashboard(user: user), context),
        ]));
  }
}

class Verification extends StatefulWidget {
  final User user;

  const Verification({Key? key, required this.user}) : super(key: key);

  @override
  State<Verification > createState() => _Verification ();
}

class _Verification extends State<Verification> {
  late User user = widget.user;
  late TextEditingController smsCodeTextFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    smsCodeTextFieldController = TextEditingController();
  }

  Future checkVerification() async {
    final response = await http.post(Uri.parse("${url()}verification"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'code': smsCodeTextFieldController.text,
        }));
    String responseMessage = response.body;
    if (responseMessage == "Codes Matched!") {
      save();
    } else {
      if (!mounted) return;
      alert(responseMessage, context);
    }
  }

  Future save() async {
    final response = await http.post(Uri.parse("${url}register"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'role': user.role
        }));
    var responseData = json.decode(response.body);
    if (responseData['message'] != null) {
      if (!mounted) return;
      alert(responseData['message'], context);
    } else {
      user.setNeededDetails(responseData);
      if (!mounted) return;
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: DoctorDashboard(user: user)));
    }
  }

  Widget buttonVerify(
      Color color, String message, Widget page, BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
              constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
              child: ElevatedButton(
                  onPressed: () async {
                    if (smsCodeTextFieldController.text != "") {
                      checkVerification();
                    } else {
                      alert("Code Not Entered!", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(230, 50),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: color),
                  child: Text(message,
                      style: CustomText.setCustom(FontWeight.w900, 16, Colors.white),
                      )
              )
          )
        ]));
  }

  Widget code() {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: TextFormField(
                      controller: smsCodeTextFieldController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Enter Code ',
                        labelStyle: CustomText.setCustom(FontWeight.w500, 14),
                        hintText: '0000000',
                        hintStyle: CustomText.setCustom(FontWeight.w500, 14),
                        enabledBorder: CustomOutlineInputBorder.custom,
                        focusedBorder: CustomOutlineInputBorder.custom,
                        errorBorder: CustomOutlineInputBorder.custom,
                        focusedErrorBorder: CustomOutlineInputBorder.custom,
                      ),
                      style: CustomText.setCustom(FontWeight.w500, 14),
                      keyboardType: TextInputType.number,
                    )))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF2190E5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(1000),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.black,
                      )),
                ]),
              )),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'Doctor Verification',
                    style: TextStyle(
                      fontFamily: 'Overpass',
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Color(0xFF2190E5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 70, 0),
                    child: Text(
                        'Please enter the code that you received via email',
                        style: TextStyle(
                          fontFamily: 'Overpass',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                  ),
                ),
              ],
            ),
          ),
          code(),
          pad(20, 0, 0, 35),
          buttonVerify(const Color(0xFF2190E5), "Create Account",
              ProfileCreation(user: user), context),
        ]));
  }
}
