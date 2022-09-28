import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/main.dart';
import 'package:nd_telemedicine/pages/homepage/admin_home.dart';
import '../../utilities/custom_functions.dart';
import '../../widgets/alerts.dart';
import 'dart:convert';
import 'dart:math';
import '../../models/user.dart';
import '../../widgets/buttons.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/navbar.dart';

class AddDoctor extends StatefulWidget {
  final User user;
  const AddDoctor({Key? key, required this.user}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctor();
}

class _AddDoctor extends State<AddDoctor> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late User user;

  bool _changeEmail = false;
  String? email;

  changeEmailValue(String? newText) {
    setState(() {
      _changeEmail = !_changeEmail;
      email = newText;
    });
  }

  @override
  void initState() {
    super.initState();
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
        sendEmail(email!, generatedCode);
        if (!mounted) return;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminHomePage(user: user)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarItem(
            icon: CupertinoIcons.home,
            index: 2, user: user,
          ),
          title: const Text("Home",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5, user: user,
            ),
            const SizedBox(width: 20),
            AppBarItem(
              icon: CupertinoIcons.settings_solid,
              index: 5, user: user,
            ),
            const SizedBox(width: 20),

          ],
        ),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children:const [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'Add Doctor',style: TextStyle(fontSize: 30),
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 70, 20),
                    child: Text(
                        'Please enter the email of doctor that you wish to add',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          UserEmail(changeClassValue: changeEmailValue),
          Padding(
            padding: const EdgeInsets.only(top:20,bottom:35),
            child: SubmitButton(
              color: Colors.blueAccent,
              message: "Send",
              width: 225,
              height: 50,
              onPressed: ()async {
                if(email!="") {
                  save();
                } else {
                  alert("Email Not Entered!", context);
                }
                },
            ),
          )]));
  }
}
