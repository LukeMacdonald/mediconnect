import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client/create_profile.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'register.dart';
import "dashboard.dart";
import 'dart:convert';


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  User user = User("", "", "");
  String url = "http://localhost:8080/LogInAttempt";
  String url2 = "http://localhost:8080/LogIn";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future login() async {
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
        }));
    if (!mounted) return;
    if (response.body == "false") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileCreation(
                  user: user))); // Should direct to profile creation page
    } else if (response.body == "true") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } else {
      alert("User does not exist");
    }
  }

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

  Widget userEmail() {
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
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget userPassword() {
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
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Password is Empty';
                }
                return null;
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

  Widget userLogInBtn() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  if (user.email == "" || user.password == "")
                    {alert("An input field is empty")}
                  else
                    {login()}
                },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color.fromRGBO(57, 210, 192, 1)),
            child: Text('Sign In',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))));
  }

  Widget userLogIn() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          userEmail(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          userPassword(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          userLogInBtn(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          const Text("Dont Have an Account?",
              style: TextStyle(color: Colors.white)),
          TextButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Registration(),
                        )),
                  },
              child: const Text("Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  )))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
                color: const Color(0xFF14181B),
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
                Text('Sign In',
                    style: GoogleFonts.roboto(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 60),
                    )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                      //height: MediaQuery.of(context).size.height * 1,
                      constraints:
                          const BoxConstraints(minWidth: 700, minHeight: 580),
                      decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                      child: userLogIn()),
                ),
              ],
            ))));
  }
}
