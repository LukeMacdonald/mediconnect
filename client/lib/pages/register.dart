import 'dart:convert';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import '../models/user.dart';
import '../styles/background_style.dart';
import '../styles/custom_styles.dart';
import '../utilities/custom_functions.dart';
import '../widgets/alerts.dart';
import '../widgets/format.dart';
import '../widgets/navbar.dart';
import 'create_profile.dart';
import 'dashboard.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;

  late bool passwordVisibility;
  late bool passwordConfirmVisibility;

  late String role;
  late User user;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();

    user = User("", "", "","");
    role = "";

    passwordVisibility = false;
    passwordConfirmVisibility = false;

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
                          emailController.text, passwordController.text, role,passwordConfirmController.text);
                      save();
                    } else if (role == "Doctor") {
                      user = User(
                          emailController.text, passwordController.text,role, passwordConfirmController.text);
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
                      labelStyle: CustomText.setCustom(FontWeight.w500, 16.0),
                      hintText: 'Enter Password',
                      hintStyle: CustomText.setCustom(FontWeight.w500, 16.0),
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
                  style: CustomText.setCustom(FontWeight.w500, 16.0),
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
                      labelStyle: CustomText.setCustom(FontWeight.w500, 16.0),
                      hintText: 'Enter Password',
                      hintStyle: CustomText.setCustom(FontWeight.w500, 16.0),
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
                  style: CustomText.setCustom(FontWeight.w500, 16.0),
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
                    labelStyle: CustomText.setCustom(FontWeight.w500, 16.0),
                    hintText: 'Enter your email address...',
                    hintStyle: CustomText.setCustom(FontWeight.w500, 16.0),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: CustomText.setCustom(FontWeight.w500, 16.0),
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
          'role': user.role,
          'confirmPassword': user.confirmPassword,
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
          navbar2(context),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
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
            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 10, 15),
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
          padding(20, 0, 0, 15),
          userRole(),
          padding(20, 20, 0, 0),
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

  Future save() async {
    print(user.role);
    final response = await http.post(Uri.parse("${url()}register/doctor"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'role': user.role,
          'confirmPassword': user.confirmPassword,
          'code': smsCodeTextFieldController.text,
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
              child: ProfileCreation(user: user)));
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
                      save();
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
          navbar2(context),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'Doctor Verification',
                    style: CustomText.setCustom(FontWeight.w800,30,const Color(0xFF2190E5),
                    ),
                  )
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 70, 0),
                    child: Text(
                        'Please enter the code that you received via email',
                        style: CustomText.setCustom(FontWeight.w500,14),
                    ),
                  ),
                )
              ],
            ),
          ),
          code(),
          padding(20, 20, 0, 0),
          buttonVerify(const Color(0xFF2190E5), "Create Account",
              ProfileCreation(user: user), context),
        ]));
  }
}
