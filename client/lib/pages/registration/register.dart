import 'dart:convert';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/pages/registration/verification.dart';
import 'package:nd_telemedicine/pages/registration/create_profile.dart';
import 'package:nd_telemedicine/styles/theme.dart';
import 'package:nd_telemedicine/widgets/buttons.dart';

import '../../main.dart';
import '../../models/user.dart';
import '../../widgets/alerts.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/icon_buttons.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _changeEmail = false;
  bool _changePassword = false;
  bool _changeConfirmPassword = false;

  String? role;
  String? email;
  String? password;
  String? confirmPassword;

  changeEmailValue(String? newText) {
    setState(() {
      _changeEmail = !_changeEmail;
      email = newText;
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

  late User user;

  @override
  void initState() {
    super.initState();
    user = User("", "", "", "");
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
      unSelectedBorderColor: AppColors.secondary,
      selectedBorderColor: Colors.lightBlue,
      unSelectedColor: AppColors.secondary,
      selectedColor: Colors.lightBlue,
      padding: 5,
    );
  }

  Future<void> validateSave() async {
    if (email == "" || email == null) {
      alert("Invalid Input!\nEmail Required!", context);
      //alert("Invalid Input!\nEmail Required!", context);
    } else if (password == "" || password == null) {
      alert("Invalid Input!\nPassword Required!", context);
    } else if (confirmPassword == "" || confirmPassword == null) {
      alert("Invalid Input!\nConfirm Password Required!", context);
    } else if (confirmPassword != password) {
      alert("Invalid Input!\nPassword Dont Match!", context);
    } else if (role != "Doctor" && role != "Patient") {
      alert("Invalid Input!\nRole Not Selected!", context);
    } else {
      user = User(email!, password!, role!, confirmPassword);
      if (role == "Doctor") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Verification(user: user)));
      } else {
        try {
          final response = await http.post(
              Uri.parse("${authenticationIP}register"),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(user.toJson()));
          switch (response.statusCode) {
            case 201:
              var responseData = json.decode(response.body);
              user.setNeededDetails(responseData);
              if (!mounted) return;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileCreation(user: user)));
              break;
            default:
              var list = json.decode(response.body).values.toList();
              throw Exception(list.join("\n\n"));
          }
        } catch (e) {
          alert(e.toString().substring(11), context);
        }
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: false,
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
        body: Column(mainAxisSize: MainAxisSize.max, children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 30, 10, 15),
              child: Text(
                'Create an account below, by entering your information.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            UserEmail(changeClassValue: changeEmailValue),
            UserGivenPassword(changeClassValue: changePasswordValue),
            UserGivenConfirmPassword(
                changeClassValue: changeConfirmPasswordValue),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'What Are You Registering as:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            //padding(20, 0, 0, 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: userRole(),
            ),
            SubmitButton(
                color: Colors.teal,
                message: "Continue",
                width: 235,
                height: 50,
                onPressed: () async {
                  validateSave();
                }),
          ]),
        );
  }
}
