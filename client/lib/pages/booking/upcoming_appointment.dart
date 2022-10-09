import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../../utilities/imports.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class UpcomingAppointment extends StatefulWidget {
  const UpcomingAppointment({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointment();
}

class _UpcomingAppointment extends State<UpcomingAppointment> {
  String token = "";
  String id = "";
  int pageIndex = 9;

  Future set() async {
    await UserSecureStorage.getID().then((value) => id = value!);
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    getUpcomingAppointment();
  }

  final List<String> _appointment = [];
  final List<String> _appointmentIds = [];
  List<String> details = [];
  final Map _hours = {
    '09:00': '09:00 - 10:00',
    '10:00': '10:00 - 11:00',
    '11:00': '11:00 - 12:00',
    '12:00': '12:00 - 13:00',
    '13:00': '13:00 - 14:00',
    '14:00': '14:00 - 15:00',
    '15:00': '15:00 - 16:00',
    '16:00': '16:00 - 17:00'
  };

  @override
  void initState() {
    set();
    super.initState();

  }

  Future getUpcomingAppointment() async {
    final response = await http.get(
        Uri.parse("${appointmentIP}search/userappointments/$id"));
    var responseData = json.decode(response.body);

    for (var appointment in responseData) {
      var doctorId = appointment['doctor'];
      final responseName =
          await http.get(Uri.parse("${authenticationIP}get/name/$doctorId"));
      //print(responseName.body);
      String doctor = responseName.body;
      String date = appointment['date'];
      String time = _hours[appointment['time']];

      _appointment.add("$doctor | $date | $time");
      _appointmentIds.add(appointment['id'].toString());
    }
    setState(() {

    });
  }

  Future deleteAppointment(int index) async {
    await http.delete(Uri.parse(
        "${appointmentIP}delete/appointment/${_appointmentIds[index]}"));
  }

  Future<String?> alert(String message) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text(message), actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ]));
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget appointmentList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          SizedBox(height: 550,
              child: SizedBox(height: 200, child: _createListView()))
        ]);
  }

  Widget setting() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[const SizedBox(height: 10), Container()]);
  }

  Widget appointment() {
    return SingleChildScrollView(
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
          const Align(
              alignment: AlignmentDirectional(-1, 0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Text('Upcoming Appointments',
                  style: TextStyle(fontSize: 20),)
              ),
              ),
          appointmentList(),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarItem(
            icon: CupertinoIcons.home,
            index: pageIndex,
          ),
          title: const Text("Appointments",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: const HeathStatusPage()));
                  }, icon: const Icon(CupertinoIcons.plus)),
            ),
            const AppDropDown(),
          ],
        ),
        body: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    height: 20,
                    decoration: const BoxDecoration(color: Colors.transparent)),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                      //height: MediaQuery.of(context).size.height * 1,
                      constraints:
                          const BoxConstraints(minWidth: 700, minHeight: 580),
                      decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                      child: appointment()),
                ),
               ],
            )),
        bottomNavigationBar: const CustomBBottomNavigationBar(pageIndex: 3));
  }
  void splitString(String detail) {
    details = detail.split(" | ");
  }
  Widget _createListView() {
    return ListView.builder(
        itemCount: _appointment.length,
        itemBuilder: (context, index) {
          splitString(_appointment[index]);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text("Doctor: ${details[0]}\nDate: ${details[1]}\nTime: ${details[2]}"),//Text(_appointment[index]),
                  trailing: SizedBox(
                      width: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: UpdateAppointment(
                                            appointmentDetails:
                                            "${_appointment[index]} | ${_appointmentIds[index]}")));
                              },
                              icon: const Icon(Icons.edit,color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                deleteAppointment(index);
                                SnackBar snackBar = SnackBar(
                                  content: Text(
                                      "Appointment Removed :  ${_appointment[index]}"),
                                  backgroundColor: Theme.of(context).cardColor,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                setState(() {
                                  _appointment.removeAt(index);
                                });
                              },
                              icon:  const Icon(Icons.delete,color: Colors.grey),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          );
        });
  }
}
