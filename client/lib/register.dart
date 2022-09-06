import 'dart:convert';

import 'package:client/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client/medical_history.dart';
import 'package:http/http.dart' as http;

import 'user.dart';
import 'log_in.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  User user = User("", "", "");
  String passwordConfirm = "";
  String verificationCode = "";

  String url = "http://localhost:8080/Register";
  String url2 = "http://localhost:8080/DoctorVerification";

  Future checkVerification() async {
    final response = await http.post(Uri.parse(url2),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'code': verificationCode,
        }));
    String responseMessage = response.body;
    if (responseMessage == "Codes Matched!") {
      save();
    } else {
      alert(responseMessage);
    }
  }

  Future save() async {
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'role': user.role
        }));
    //print(response.body);
    if (response.body == "Saved user...") {
      if (!mounted) return;
      if (user.role == 'patient') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MedicalHistory()));
      } else if (user.role == 'doctor') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } else {
      alert("Email Already Taken!");
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isCheckedP = false;
  bool isCheckedD = false;

  Future<String?> alert(String message) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text(message), actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ]));
  }

  // Patient Registration Widgets
  Widget patientEmail() {
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
              controller: TextEditingController(text: user.email),
              onChanged: (val) {
                user.email = val;
              },
              validator: (val) {
                if (val == "") {
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
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget patientPassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
              obscureText: true,
              controller: TextEditingController(text: user.password),
              onChanged: (val) {
                user.password = val;
              },
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget patientPassword2() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
              obscureText: true,
              controller: TextEditingController(text: passwordConfirm),
              onChanged: (val) {
                passwordConfirm = val;
              },
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget patientCreateBtn() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  if (user.email == "")
                    {alert('Email is empty')}
                  else if (user.password == "" || passwordConfirm == "")
                    {alert('A password input is empty')}
                  else if (passwordConfirm == user.password &&
                      user.password != "")
                    {
                      if (user.emailValid(user.email) == true)
                        {
                          user.role = 'patient',
                          save(),
                        }
                      else
                        {alert('Email is in invalid format')}
                    }
                  else
                    {alert('Passwords Don\'t Match')}
                },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color.fromRGBO(57, 210, 192, 1)),
            child: Text('Create Account',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))));
  }

  Widget patientCheckBox() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 300),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CheckboxListTile(
          checkColor: Colors.white,
          value: isCheckedP,
          title: const Text("Skip Profile Creation",
              style: TextStyle(
                color: Colors.white,
              )),
          side: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            setState(() {
              isCheckedP = value!;
            });
          },
        ));
  }

  Widget patientRegistration() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          patientEmail(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          patientPassword(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          patientPassword2(),
          patientCheckBox(),
          patientCreateBtn(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          const Text("Already Have an Account?",
              style: TextStyle(color: Colors.white)),
          TextButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogIn()))
            },
            child: const Text("Log In",
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                )),
          )
        ]));
  }

  // Doctor Registration Widgets
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
              controller: TextEditingController(text: user.email),
              onChanged: (val) {
                user.email = val;
              },
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget doctorPassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
              obscureText: true,
              controller: TextEditingController(text: user.password),
              onChanged: (val) {
                user.password = val;
              },
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget doctorPassword2() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
              obscureText: true,
              controller: TextEditingController(text: passwordConfirm),
              onChanged: (val) {
                passwordConfirm = val;
              },
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget doctorCreateBtn() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  if (user.email == "")
                    {alert('Email is empty!')}
                  else if (user.password == "" || passwordConfirm == "")
                    {alert('A password input is empty')}
                  else if (passwordConfirm == user.password &&
                      user.password != "")
                    {
                      if (user.emailValid(user.email) == true)
                        {user.role = 'doctor', checkVerification()}
                      else
                        {alert('Email is in invalid format!')}
                    }
                  else
                    {alert('Passwords Don\'t Match')}
                },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color.fromRGBO(57, 210, 192, 1)),
            child: Text('Create Account',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))));
  }

  Widget doctorCheckBox() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 300),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CheckboxListTile(
          checkColor: Colors.white,
          value: isCheckedD,
          title: const Text("Skip Profile Creation",
              style: TextStyle(color: Colors.white)),
          side: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            setState(() {
              isCheckedD = value!;
            });
          },
        ));
  }

  Widget doctorVerification() {
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
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.verified),
                  hintText: 'Verification Code',
                  hintStyle: TextStyle(color: Colors.black38)),
              onChanged: (val) {
                verificationCode = val;
              },
            ),
          )
        ]);
  }

  Widget doctorRegistration() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          doctorEmail(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          doctorVerification(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          doctorPassword(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          doctorPassword2(),
          doctorCheckBox(),
          doctorCreateBtn(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          const Text("Already Have an Account?",
              style: TextStyle(color: Colors.white)),
          TextButton(
            onPressed: () => {},
            child: const Text("Log In",
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                )),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: const AssetImage('images/background.jpeg'),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken))),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    height: 20,
                    decoration: const BoxDecoration(color: Colors.transparent)),
                Image.asset('images/Logo.png', height: 150),
                Text('Sign Up',
                    style: GoogleFonts.roboto(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 60),
                    )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                    //height: MediaQuery.of(context).size.height * 1,
                    constraints:
                        const BoxConstraints(maxWidth: 700, maxHeight: 580),
                    decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          const TabBar(
                            isScrollable: true,
                            labelColor: Colors.white,
                            labelStyle: TextStyle(fontSize: 14.0),
                            indicatorColor: Colors.cyan,
                            tabs: [
                              Tab(
                                text: 'Patient',
                              ),
                              Tab(
                                text: 'Doctor',
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                patientRegistration(),
                                doctorRegistration(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))));
  }
}
