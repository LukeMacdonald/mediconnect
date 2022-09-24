import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/main.dart';
import '../styles/background_style.dart';
import '../styles/custom_styles.dart';
import '../utilities/custom_functions.dart';
import '../widgets/alerts.dart';
import '../widgets/format.dart';
import 'dashboard.dart';
import 'dart:convert';
import 'dart:math';
import '../models/user.dart';

class AddDoctor extends StatefulWidget {
  final User user;
  const AddDoctor({Key? key, required this.user}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctor();
}

class _AddDoctor extends State<AddDoctor> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  late User user;
  late String email;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    user = widget.user;
  }

  Future save() async {
    // Randomly generate a code of length 5, with values between [0-9]
    var rng = Random();

    String generatedCode = "";

    for (var i = 0; i < 5; ++i) {
      generatedCode = generatedCode + rng.nextInt(10).toString();
    }
    var response = await http.post(
        Uri.parse("${url()}admin/EmailVerificationInTable"),
        headers: {'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${user.accessToken}"},
        body: json.encode({'email': email, 'code': generatedCode}));

    dynamic responseData = json.decode(response.body);

    if(response.statusCode == 403 && responseData['error_message'].contains('Token has expired')){
        response = await http.get(
            Uri.parse("${url()}token/refresh"),
            headers: {'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: "Bearer ${user.refreshToken}"});
        responseData = json.decode(response.body);
        user.accessToken = responseData['access_token'];
        user.refreshToken = responseData['refresh_token'];
        save();
      }
      else if (response.statusCode == 403) {
        if (!mounted) return;
        alert("Unauthorised Access!", context);
      }
      else if(response.statusCode == 401){
        if (!mounted) return;
        alert("Email exists!", context);
      }
      else if (response.body == "Valid email to store") {
        sendEmail(email, generatedCode);
        if (!mounted) return;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuperAdminDashboard(user: user)));
      } else {
        if (!mounted) return;
        alert("Email exists!", context);
      }
  }


  Future sendEmail(String email, String code) async {
    final response =
    await http.post(Uri.parse("${communicationIP}sendMail"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'recipient': email,
          'msgBody':
          "Hello,\n\nThe following verification code must be provided to register,\n$code\nBest Wishes,\nFrom the ND Telemedicine Management Team",
          'subject': "ND-Telemedicine Doctor Verification Code"
        }));
    return response.body;
  }

  Widget emailInput() {
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

  Widget buttonVerify(Color color, String message, Widget page,
      BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
              constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
              child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text != "") {
                      email = emailController.text;
                      save();
                    } else {
                      alert("Email Not Entered!", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(230, 50),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: color),
                  child: Text(message,
                    style: CustomText.setCustom(
                        FontWeight.w900, 16, Colors.white),
                  )
              )
          )
        ]));
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
              children:[
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'Add Doctor',
                    style: CustomText.setCustom(FontWeight.w800, 30,const Color(0xFF2190E5)),
                  ),
                ),
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
                        'Please enter the email of doctor that you wish to add',
                        style: CustomText.setCustom(FontWeight.w500, 14),
                    ),
                  ),
                )
              ],
            ),
          ),
          emailInput(),
          padding(20, 0, 0, 35),
          buttonVerify(const Color(0xFF2190E5), "Add Doctor",
              SuperAdminDashboard(user: user), context),
        ]));
  }
}
