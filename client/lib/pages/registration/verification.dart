import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/security/storage_service.dart';
import 'package:page_transition/page_transition.dart';
import '../../pages/imports.dart';
import 'package:http/http.dart' as http;


class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _Verification();
}

class _Verification extends State<Verification> {
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
    if (code == "" || code == null) {
      alert("No Code Entered!", context);
    } else {
      try {
        final response = await http.post(
            Uri.parse("${authenticationIP}register/doctor"),
            headers: {'Content-Type': 'application/json'},
            body:

                jsonEncode(await UserSecureStorage().doctorToJson(int.parse(code!))));
        switch (response.statusCode) {
          case 201:
            var responseData = json.decode(response.body);
            UserSecureStorage.setID(responseData['id']);
            if(!mounted)return;
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ProfileCreation()));
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
    return GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
    child:Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
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
    ])));
  }
}
