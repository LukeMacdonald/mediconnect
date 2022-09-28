import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/pages/homepage/doctor_home.dart';
import 'package:nd_telemedicine/pages/homepage/home_page.dart';
import 'package:nd_telemedicine/widgets/form_widgets.dart';
import '../../main.dart';
import '../../widgets/alerts.dart';
import '../../widgets/buttons.dart';
import '../../widgets/icon_buttons.dart';
import '../../models/user.dart';

class ProfileCreation extends StatefulWidget {
  final User user;

  const ProfileCreation({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _ProfileCreation();
}
class _ProfileCreation extends State<ProfileCreation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late User user = widget.user;
  @override
  void initState() {
    super.initState();
  }
  Future save() async {
    await http.put(Uri.parse("${authenticationIP}update"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: user.accessToken
        },
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'role': user.role,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'phoneNumber': user.phoneNumber,
          'dob': user.dob
        }));
    user.password = "";
    if (!mounted) return;
    if (user.role == 'patient') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(user: user)));
    } else if (user.role == 'doctor') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DoctorHomePage(user: user)));
    }
  }

  bool _changeFirstName = false;
  bool _changeLastName = false;
  bool _changeDOB = false;
  bool _changePhoneNumber = false;
  bool _changePassword = false;
  bool _changeConfirmPassword = false;

  String? firstName;
  String? lastName;
  String? dob;
  String? phone;
  String? password;
  String? confirmPassword;

  changeFirstNameValue(String? newText) {
    setState(() {
      _changeFirstName = !_changeFirstName;
      firstName = newText;
    });
  }

  changeLastNameValue(String? newText) {
    setState(() {
      _changeLastName = !_changeLastName;
      lastName = newText;
    });
  }

  changePhoneNumberValue(String? newText) {
    setState(() {
      _changePhoneNumber = !_changePhoneNumber;
      phone = newText;
    });
  }

  changePasswordValue(String? newText) {
    setState(() {
      _changePassword = !_changePassword;
      password = newText;
    });
  }

  changeConfirmPasswordValue(String? newText) {
    setState(() {
      _changeConfirmPassword = !_changeConfirmPassword;
      confirmPassword = newText;
    });
  }

  changeDOBValue(String? newText) {
    setState(() {
      _changeDOB = !_changeDOB;
      dob = newText;
    });
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
                    UserGivenFirstName(changeClassValue: changeFirstNameValue),
                    UserGivenLastName(changeClassValue: changeLastNameValue),
                    UserDOB(changeClassValue: changeDOBValue),
                    UserGivenPhoneNumber(
                        changeClassValue: changePhoneNumberValue),
                    UserGivenPassword(changeClassValue: changePasswordValue),
                    UserGivenConfirmPassword(
                        changeClassValue: changeConfirmPasswordValue),
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
                        if (firstName == "") {
                          alert("Please Enter Your First Name!", context);
                        } else if (lastName == "") {
                          alert("Please Enter Your Last Name!", context);
                        } else if (dob == "") {
                          alert("Please Enter Your Date of Birth!", context);
                        } else if (phone == "") {
                          alert("Please Enter Your Phone Number!", context);
                        } else if (password == "") {
                          alert("Please Enter Your Password!", context);
                        } else if (confirmPassword == "") {
                          alert("Please Confirm Your Password!", context);
                        } else if (confirmPassword?.compareTo(password!) != 0) {
                          alert("Passwords Did Not Match!", context);
                        } else {
                          user.firstName = firstName!;
                          user.lastName = lastName!;
                          user.dob = dob!;
                          user.phoneNumber = phone!;
                          user.password = password!;
                          save();
                        }
                      },
                    ),
                  ),
                ]),
            ));
  }
}
