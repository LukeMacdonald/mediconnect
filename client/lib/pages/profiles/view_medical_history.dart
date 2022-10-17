import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/utilities/imports.dart';
import 'package:http/http.dart' as http;

class ViewOtherMedicalHistory extends StatefulWidget {
  final int id;
  const ViewOtherMedicalHistory({Key? key, required this.id}) : super(key: key);

  @override
  _ViewOtherMedicalHistoryState createState() =>
      _ViewOtherMedicalHistoryState();
}

class _ViewOtherMedicalHistoryState extends State<ViewOtherMedicalHistory> {
  late Bool smokes;
  late Bool drinks;
  late String illnesses = "";
  late String disabilities = "";

  Future getMedicalHistory() async {
    var response = await http.get(Uri.parse(
        "${medicationIP}get/healthinformation/${UserSecureStorage.getID()}"));

    var responseData = json.decode(response.body);
    smokes = responseData['smoke'];
    drinks = responseData['drink'];

    response = await http.get(
        Uri.parse("${medicationIP}get/illnesses/${UserSecureStorage.getID()}"));
    responseData = json.decode(response.body);
    illnesses = responseData['illness'];

    response = await http.get(Uri.parse(
        "${medicationIP}get/disabilities/${UserSecureStorage.getID()}"));
    responseData = json.decode(response.body);
    illnesses = responseData['disability'];

    setState(() {});
  }

  @override
  void initState() {
    getMedicalHistory();
    super.initState();
  }

  // TODO: GET MEDICAL HISTORY FROM BACKEND
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
              title: const Text("Medical History"),
            ),
            //_
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView(
                    children: [
                      Icon(
                        CupertinoIcons.info_circle_fill,
                        size: 120,
                        color: AppColors.secondary,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "Medical History",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Smokes: $smokes",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Drinks: $drinks",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Takes Medication: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Medications: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Illnesses: $illnesses",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Disabilities: $disabilities",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class ViewMedicalHistory extends StatefulWidget {
  final int id;
  const ViewMedicalHistory({Key? key, required this.id}) : super(key: key);

  @override
  _ViewMedicalHistoryState createState() => _ViewMedicalHistoryState();
}

class _ViewMedicalHistoryState extends State<ViewMedicalHistory> {
  // TODO: GET MEDICAL HISTORY FROM BACKEND
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
              title: const Text("Medical History"),
            ),
            //_
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView(
                    children: [
                      Icon(
                        CupertinoIcons.info_circle_fill,
                        size: 120,
                        color: AppColors.secondary,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "Medical History",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Smokes: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Drinks: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Takes Medication: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Medications: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Illnesses: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Disabilities:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SubmitButton(
                          color: Colors.teal,
                          message: "Update Medical History",
                          width: 50,
                          height: 50,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
