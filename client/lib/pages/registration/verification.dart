import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/main.dart';
import 'package:nd_telemedicine/widgets/form_widgets.dart';

import '../../models/user.dart';
import 'create_profile.dart';
import '../../styles/custom_styles.dart';
import '../../styles/theme.dart';
import '../../widgets/alerts.dart';
import '../../widgets/buttons.dart';
import 'package:http/http.dart' as http;

import '../../widgets/icon_buttons.dart';

class Verification extends StatefulWidget {
  final User user;
  const Verification({Key? key, required this.user}) : super(key: key);

  @override
  State<Verification> createState() => _Verification();
}

class _Verification extends State<Verification> {
  late User user = widget.user;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _changeCode = false;
  String? code;

  changeCodeValue(String? newText) {
    setState(() {
      _changeCode = !_changeCode;
      code = newText;
    });
  }

  Future<void> validateSave() async {
    if (code == "" || code != null) {
      alert("No Code Entered!", context);
    } else {
      try {
        final response = await http.post(
            Uri.parse("${authenticationIP}register"),
            headers: {'Content-Type': 'application/json'},
            body:
                jsonEncode(user.doctorToJson(int.parse(code!))));
        switch (response.statusCode) {
          case 201:
            var responseData = json.decode(response.body);
            user.setNeededDetails(responseData);
            ProfileCreation(user: user);
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
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: const [
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text('Doctor Verification',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondary)))
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DoctorCode(changeClassValue: changeCodeValue),
      ),
      SubmitButton(
        color: Colors.teal,
        message: "Continue",
        width: 200,
        height: 50,
        onPressed: () async {
          validateSave();
        },
      )
    ]));
  }
}
