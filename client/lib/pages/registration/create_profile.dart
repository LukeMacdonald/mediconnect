import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../../pages/imports.dart';

class ProfileCreation extends StatefulWidget {

  const ProfileCreation({Key? key}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _ProfileCreation();
}
class _ProfileCreation extends State<ProfileCreation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }
  Future save() async {
    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);

    await http.put(Uri.parse("${authenticationIP}update"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: token
        },
        body: json.encode(await UserSecureStorage().toFullJson()));

    if (!mounted) return;
    if (await UserSecureStorage.getRole() == 'patient') {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: const HomePage()));
    } else if (await UserSecureStorage.getRole() == 'doctor') {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: const DoctorHomePage()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: SizedBox(
            child: Column(
                    children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Text(
                            'Profile Creation',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              color: Color(0xFF2190E5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(children:[
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 70, 5),
                              child: Text(
                                'Please enter your personal details below:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const UserGivenFirstName(),
                    const UserGivenLastName(),
                    const UserDOB(),
                    const UserGivenPhoneNumber(),
                    const UserGivenPassword(),
                    const UserGivenConfirmPassword(),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:10),
                    child: SubmitButton(
                      color: Colors.teal,
                      message: "Submit",
                      width: 220,
                      height: 50,
                      onPressed: () async {
                        if (await UserSecureStorage.getFirstName() == "" || await UserSecureStorage.getFirstName() == null) {
                          alert("Please Enter Your First Name!", context);
                        } else if (await UserSecureStorage.getLastName() == "" || await UserSecureStorage.getLastName() == null) {
                          alert("Please Enter Your Last Name!", context);
                        } else if (await UserSecureStorage.getDOB() == "" || await UserSecureStorage.getDOB() == null) {
                          alert("Please Enter Your Date of Birth!", context);
                        } else if (await UserSecureStorage.getFirstName() == "" || await UserSecureStorage.getPhoneNumber() == null) {
                          alert("Please Enter Your Phone Number!", context);
                        } else if (await UserSecureStorage.getPassword() == "" || await UserSecureStorage.getPassword()== null) {
                          alert("Please Enter Your Password!", context);
                        } else if (await UserSecureStorage.getConfirmPassword() == "" || await UserSecureStorage.getConfirmPassword() == null) {
                          alert("Please Confirm Your Password!", context);
                        } else if (await UserSecureStorage.getConfirmPassword()!= await UserSecureStorage.getPassword()) {
                          alert("Passwords Did Not Match!", context);
                        } else {

                          save();
                        }
                      },
                    ),
                  ),
                ]),
            ));
  }
}
