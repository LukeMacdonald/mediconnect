import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'user.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _ProfileCreation();
}

class _ProfileCreation extends State<ProfileCreation> {
  // TODO: Need new variables for user class
  User user = User("", "");
  TextEditingController dateInput = TextEditingController();
  String firstName = "";
  String lastName = "";
  String DOB = "";
  String phoneNumber = "";
  String passwordConfirm = "";

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  String url = "http://localhost:8080/profile_creation";

  Future save() async {
    await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isCheckedP = false;
  bool isCheckedD = false;

  // User Profile Creationg Widgets
  Widget userGivenName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        const Padding(padding: EdgeInsets.fromLTRB(360, 0, 0, 0)),
        Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 240),
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
              //TODO: change variable from user.email first name
              controller: TextEditingController(text: firstName),
              onChanged: (val) {
                firstName = val;
              },
              validator: (val) {
                if (val == "") {
                  return 'First name is empty';
                }
                return null;
              },
              // keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'First Name',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 240),
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
                //TODO: change variable from user.email to last name
                controller: TextEditingController(text: lastName),
                onChanged: (val) {
                  lastName = val;
                },
                validator: (val) {
                  if (val == "") {
                    return 'Last name is empty';
                  }
                  return null;
                },
                // keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Last Name',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ),
          )
        ])
      ],
    );
  }

  Widget userPassword() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        const Padding(padding: EdgeInsets.fromLTRB(360, 0, 0, 0)),
        Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 240),
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
                if (val == "") {
                  return 'Password is empty';
                }
                return null;
              },
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 240),
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
                //TODO: change variable from user.email to confirm password
                controller: TextEditingController(text: passwordConfirm),
                onChanged: (val) {
                  passwordConfirm = val;
                },
                validator: (val) {
                  if (val == "") {
                    return 'Confirm Password is empty';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ),
          )
        ])
      ],
    );
  }

  Widget userDOB() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
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
              //TODO: change to a date_time_picker
              child: Center(
                  child: TextField(
                      controller: dateInput,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 15),
                          prefixIcon: Icon(Icons.calendar_today),
                          hintText: 'Date of Birth',
                          hintStyle: TextStyle(color: Colors.black38)),
                      readOnly: true,
                      // set it true, user cannot edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            dateInput.text = formattedDate;
                          });
                        }
                      })))
        ]);
  }

  Widget userPhoneNumber() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
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
              //TODO: change variable to phone number
              controller: TextEditingController(text: phoneNumber),
              onChanged: (val) {
                phoneNumber = val;
              },
              validator: (val) {
                if (val == "") {
                  return 'Phone Number is Empty';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget profileCreateBtn() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  if (firstName == "")
                    {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  content: const Text('First Name is Empty'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]))
                    }
                  else if (lastName == "")
                    {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  content: const Text('Last Name is Empty'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]))
                    }
                  else if (dateInput.text == "")
                    {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  content: const Text('Date of Birth is Empty'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]))
                    }
                  else if (phoneNumber == "")
                    {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  content: const Text('Phone Number is Empty'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]))
                    }
                  else if (passwordConfirm == "" || user.password == "")
                    {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  content: const Text('Password is Empty'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]))
                    }
                  else if (passwordConfirm == user.password)
                    {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  content: const Text('Creation Success!!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]))
                      //save(),
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             const MedicalHistoryCopyWidget()))
                    }
                  else
                    {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  content: const Text('Passwords Don\'t Match'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]))
                    }
                },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color.fromRGBO(57, 210, 192, 1)),
            child: Text('Create Profile',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))));
  }

  Widget profileCreation() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          userGivenName(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          userDOB(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          userPhoneNumber(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          userPassword(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          profileCreateBtn(),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
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
                Text('Create A Profile',
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
                      child: profileCreation()),
                ),
              ],
            ))));
  }
}
