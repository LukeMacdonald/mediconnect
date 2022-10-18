import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/utilities/imports.dart';
import 'package:http/http.dart' as http;
import 'package:rethink_db_ns/rethink_db_ns.dart';

class ViewOtherMedicalHistory extends StatefulWidget {
  final int id;
  const ViewOtherMedicalHistory({Key? key, required this.id}) : super(key: key);

  @override
  _ViewOtherMedicalHistoryState createState() =>
      _ViewOtherMedicalHistoryState();
}

class _ViewOtherMedicalHistoryState extends State<ViewOtherMedicalHistory> {
  bool smokes = false;
  bool drinks = false;
  late String illnesses = "";
  late String disabilities = "";


  Future getMedicalHistory() async {
    var response = await http.get(Uri.parse(
        "${medicationIP}get/healthinformation/${widget.id}"));

    var responseData = json.decode(response.body);
    smokes = responseData['smoke'];
    drinks = responseData['drink'];

    response = await http.get(
        Uri.parse("${medicationIP}get/illnesses/${widget.id}"));
    responseData = json.decode(response.body);
    illnesses = responseData['illness'];

    response = await http.get(Uri.parse(
        "${medicationIP}get/disabilities/${widget.id}"));
    responseData = json.decode(response.body);
    illnesses = responseData['disability'];

    setState(() {});
  }

  @override
  void initState() {
    getMedicalHistory();
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
                      const Icon(
                        CupertinoIcons.info_circle_fill,
                        size: 120,
                        color: AppColors.secondary,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "Medical History",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Smokes: $smokes",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Drinks: $drinks",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Takes Medication: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Medications: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Illnesses: $illnesses",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Disabilities: $disabilities",
                          style: const TextStyle(fontSize: 18),
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
  UserMedicalHistory history = UserMedicalHistory();
  String id = "";

  Future getMedicalHistory() async {
    
    await UserSecureStorage.getID().then(((value) => id = value!));
    var response = await http.get(Uri.parse(
        "${medicationIP}get/healthinformation/${int.parse(id)}"));


    var responseData = json.decode(response.body);
    history.smoke = responseData['smoke'];
    history.drink = responseData['drink'];
    response = await http.get(
        Uri.parse("${medicationIP}get/illnesses/${int.parse(id)}"));
    responseData = json.decode(response.body);
    for(dynamic element in responseData){
      history.userIllnesses.add(element['illness']);
    }
    response = await http.get(Uri.parse(
        "${medicationIP}get/disabilities/${int.parse(id)}"));
    responseData = json.decode(response.body);

    for(dynamic element in responseData){
      history.userDisabilities.add(element['disability']);
    }
    setState(() {});
  }
  @override
  void initState() {
    getMedicalHistory();
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
                      const Icon(
                        CupertinoIcons.info_circle_fill,
                        size: 120,
                        color: AppColors.secondary,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "Medical History",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Smokes: ${history.smoke}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Drinks Alcohol: ${history.drink}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Known Illnesses:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height:70,
                          child: ListView.builder(
                              itemCount: history.userIllnesses.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(history.userIllnesses[index]);
                                return Text("- ${history.userIllnesses[index]}",style: const TextStyle(fontSize: 14),);
                              }),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Known Disabilities:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height:70,
                          child: ListView.builder(
                              itemCount: history.userDisabilities.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text("- ${history.userDisabilities[index]}");
                              }),
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
                            navigate(UpdateMedicalHistory(id: int.parse(id)), context);
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
