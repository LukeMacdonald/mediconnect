import 'package:client/styles/background_style.dart';
import 'package:client/utilities/custom_functions.dart';
import 'package:client/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import "dashboard.dart";
import 'dart:convert';
import 'dart:math';
import 'utilities/user.dart';

class AddDoctor extends StatefulWidget {
  final User user;
  const AddDoctor({Key? key, required this.user}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctor();
}

class _AddDoctor extends State<AddDoctor> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  late User user = widget.user;
  late String email;

  Future save() async {
    // Randomly generate a code of length 5, with values between [0-9]
    var rng = Random();
    String generatedCode = "";
    for (var i = 0; i < 5; ++i) {
      generatedCode = generatedCode + rng.nextInt(10).toString();
    }

    final response = await http.post(
        Uri.parse("${url()}EmailVerificationInTable"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'code': generatedCode}));
    if (response.body == "Valid email to store") {
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
        await http.post(Uri.parse("${url()}sendMail"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'recipient': email,
              'msgBody':
                  "Hello,\n\nThe following verification code must be provided to register,\n$code\nBest Wishes,\nFrom the ND Telemedicine Management Team",
              'subject': "ND-Telemedicine Doctor Verification Code"
            }));
    return response.body;
  }

  Widget doctorEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextFormField(
              controller: controller,
              onChanged: (val) {
                email = val;
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Email is Empty';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter Doctor\'s Email',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget submit() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  if (email == "") {alert("Email wasn't Entered",context)} else {save()}
                },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color.fromRGBO(57, 210, 192, 1)),
            child: Text('Submit',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))));
  }

  Widget addDoctor() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
            child: Text('Add Doctor',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30)),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          doctorEmail(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          submit(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.1,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 1.2,
                    minHeight: MediaQuery.of(context).size.height * 1),
                decoration: CustomBackground.setBackground,
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0x990F1113),
                    ),
                    child: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                      Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 50, 10, 0),
                          child: Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: const Color(0x66FFFFFF),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  dashboardNavbar(),
                                  dashboardUserIcon(),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 20, 0),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Color(0x00FFFFFF)),
                                        child: addDoctor()),
                                  )
                                ],
                              )))
                    ]))))));
  }
}
