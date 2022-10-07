import 'dart:convert';

import 'package:client/update_appointment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dashboard.dart';
import 'utilities/appointment.dart';
import 'utilities/user.dart';

class UpcomingAppointment extends StatefulWidget {
  final User user;
  const UpcomingAppointment({Key? key, required this.user}) : super(key: key);

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointment();
}

class _UpcomingAppointment extends State<UpcomingAppointment> {
  late User user = widget.user;
  String url = "http://localhost:8080/";

  final List<String> _appointment = [];
  final List<String> _appointmentIds = [];
  final Map _hours = {
    '09:00:00': '09:00 - 10:00',
    '10:00:00': '10:00 - 11:00',
    '11:00:00': '11:00 - 12:00',
    '12:00:00': '12:00 - 13:00',
    '13:00:00': '13:00 - 14:00',
    '14:00:00': '14:00 - 15:00',
    '15:00:00': '15:00 - 16:00',
    '16:00:00': '16:00 - 17:00'
  };
  @override
  void initState() {
    super.initState();
    getUpcomingAppointment();
  }

  Future getUpcomingAppointment() async {
    final response =
        await http.get(Uri.parse("${url}SearchUserAppointments/${user.id}"));
    var responseData = json.decode(response.body);

    for (var appointment in responseData) {
      var doctorId = appointment['doctor'];
      final responseName =
          await http.get(Uri.parse("${url}GetUserFullName/${doctorId}"));
      String day = responseName.body.toString();
      String date = appointment['date'];
      String time = _hours[appointment['time']];
      _appointment.add("${day} | ${date} | ${time}");
      _appointmentIds.add(appointment['id'].toString());
    }
  }

  Future deleteAppointment(int index) async {
    await http
        .delete(Uri.parse("${url}DeleteAppointment/${_appointmentIds[index]}"));
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

  Widget submit() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientDashboard(user: user)))
                },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color.fromRGBO(57, 210, 192, 1)),
            child: Text('Submit',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))));
  }

  Widget appointmentList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
              constraints: const BoxConstraints(
                  minWidth: 800, maxWidth: 800, minHeight: 300, maxHeight: 300),
              decoration: BoxDecoration(
                  color: const Color(0x86C6F7FD),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              // LISTVIEW
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
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
          Align(
              alignment: const AlignmentDirectional(-1, 0.05),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                child: Text('Appointments',
                    style: GoogleFonts.lexendDeca(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ))),
              )),
          appointmentList(),
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
                Text('Upcoming Appointment',
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
                      child: appointment()),
                ),
                submit()
              ],
            ))));
  }

  Widget _createListView() {
    return ListView.builder(
        itemCount: _appointment.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0x86C6F7FD),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(_appointment[index]),
              trailing: Container(
                  width: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateAppointment(
                                        user: user,
                                        appointmentDetails:
                                            _appointment[index] +
                                                " | " +
                                                _appointmentIds[index])));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            deleteAppointment(index);
                            SnackBar snackBar = SnackBar(
                              content: Text(
                                  "Appointment Removed :  ${_appointment[index]}"),
                              backgroundColor: Color.fromARGB(255, 10, 216, 27),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            setState(() {
                              _appointment.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
