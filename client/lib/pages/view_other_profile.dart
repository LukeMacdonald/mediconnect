import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/user.dart';
import '../security/storage_service.dart';
import '../styles/theme.dart';
import 'package:http/http.dart' as http;
import '../widgets/buttons.dart';

class ViewOtherProfile extends StatefulWidget {
  final int id;
  const ViewOtherProfile({Key? key,required this.id}) : super(key: key);

  @override
  _ViewOtherProfileState createState() => _ViewOtherProfileState();
}

class _ViewOtherProfileState extends State<ViewOtherProfile> {

  bool isTextFieldDisabled = true;
  Color button = AppColors.secondary;
  String buttonText = "Update Profile";
  String titleText = "View Profile";
  User user = User();
  Future getFields() async {
    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    var response = await http
        .get(Uri.parse("${authenticationIP}get/id/${widget.id}"), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: token,
    });
    var responseData = json.decode(response.body);
    user.email = responseData['email'];
    user.firstName = responseData['firstName'];
    user.lastName = responseData['lastName'];
    user.dob= responseData['dob'];
    user.phoneNumber = responseData['phoneNumber'];
    setState(() {});
  }
  Future updateFields()async{
    UserSecureStorage.setFirstName(user.firstName);
    UserSecureStorage.setLastName(user.lastName);
    UserSecureStorage.setPhoneNumber(user.phoneNumber);
    UserSecureStorage.setDOB(user.dob);
    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    await http.put(Uri.parse("${authenticationIP}update"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: token
        },
        body: json.encode(
            {
              'email': await UserSecureStorage.getEmail(),
              'password':await UserSecureStorage.getPassword(),
              'role': await UserSecureStorage.getRole(),
              'firstName': await UserSecureStorage.getFirstName(),
              'lastName': await UserSecureStorage.getLastName(),
              'phoneNumber': await UserSecureStorage.getPhoneNumber(),
              'dob': await UserSecureStorage.getDOB(),
            }));
  }


  @override
  void initState() {
    getFields();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
                iconTheme: Theme.of(context).iconTheme,
                centerTitle: true,
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
                title: Text("View Profile"),
                ),
            //_
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView(
                    children: [
                      const Icon(CupertinoIcons.person, size: 100),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      TextFormField(

                        controller: TextEditingController()..text = user.firstName,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      TextFormField(
                        controller:TextEditingController()..text=user.lastName,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      TextFormField(
                        controller:TextEditingController()..text=user.email,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child:TextFormField(
                        readOnly: true,
                        controller: TextEditingController()..text=user.dob,
                        decoration: const InputDecoration(
                          labelText: 'DOB',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                        readOnly: true,
                            controller: TextEditingController()..text=user.phoneNumber,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
