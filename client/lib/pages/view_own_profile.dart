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

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);


  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  bool isTextFieldDisabled = true;
  Color button = AppColors.secondary;
  String buttonText = "Update Profile";
  String titleText = "View Profile";
  User user = User();

  Future getFields() async {
    //await UserSecureStorage.getID().then((value) => user.id = value! as int?);
    await UserSecureStorage.getEmail().then((value) => user.email= value!);
    await UserSecureStorage.getFirstName().then((value) => user.firstName= value!);
    await UserSecureStorage.getLastName().then((value) => user.lastName= value!);
    await UserSecureStorage.getDOB().then((value) => user.dob = value!);
    await UserSecureStorage.getPhoneNumber().then((value) => user.phoneNumber= value!);
    setState(() {

    });

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
                title: Text(titleText),
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
                        readOnly: isTextFieldDisabled,
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
                        readOnly: isTextFieldDisabled,
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
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                      child:TextFormField(
                        readOnly: isTextFieldDisabled,
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
                        readOnly: isTextFieldDisabled,
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SubmitButton(
                          color: button,
                          message: buttonText,
                          width: 50,
                          height: 50,
                          onPressed: () {
                            setState(() {
                              isTextFieldDisabled = !isTextFieldDisabled;
                              if(!isTextFieldDisabled){
                                titleText = "Update Profile";
                                buttonText = "Submit";
                                button = Colors.teal;
                              }
                              if(isTextFieldDisabled){
                                buttonText = "Update Profile";
                                titleText = "View Profile";
                                button = AppColors.secondary;
                              }
                            });
                          },
                        ),

                      ),
                      isTextFieldDisabled ? SizedBox(
                        width: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SubmitButton(
                            color: AppColors.accent,
                            message: "View Medical History",
                            width: 0,
                            height: 50,
                            onPressed: () {
                              setState(() {
                                isTextFieldDisabled = false;
                              });
                            },
                          ),

                        ),
                      ):Container(),

                    ],
                  ),
                ),
              ),
            )));
  }
}
