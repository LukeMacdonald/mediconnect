import '../../utilities/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AddDoctor extends StatefulWidget {

  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctor();
}

class _AddDoctor extends State<AddDoctor> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
  }

  Future save() async {
    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);

    try {
      final response = await http.get(
          Uri.parse("${authenticationIP}admin/add/doctor/verification/$email"),
          headers: {'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token"},);
      switch (response.statusCode) {
        case 201:
          dynamic responseData = json.decode(response.body);
          sendEmail(responseData['email'], responseData['code']);
          break;
        default:
          var list = json.decode(response.body).values.toList();
          throw Exception(list.join("\n\n"));
      }
    } catch (e) {
      if(!mounted)return;
      alert(e.toString().substring(11), context);
    }
  }
  Future sendEmail(String email, int code) async {
    try {
      final response =
      await http.post(Uri.parse("${communicationIP}send/html/mail"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'code': code}));
      switch (response.statusCode) {
        case 202:
          dynamic responseData = json.decode(response.body);
          if(!mounted)return;
          alert(responseData['message'],context);
          break;
        default:
          var list = json.decode(response.body).values.toList();
          throw Exception(list.join("\n\n"));
      }
    } catch (e) {
      alert(e.toString().substring(11), context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
    child:Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
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
          actions: const <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,
            ),
            SizedBox(width: 20),
            AppBarItem(
              icon: CupertinoIcons.settings_solid,
              index: 5,
            ),
            SizedBox(width: 20),

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
          )])));
  }
}
