import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import '../../utilities/imports.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpcomingAppointment extends StatefulWidget {
  final String role;
  const UpcomingAppointment({Key? key, required this.role}) : super(key: key);

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointment();
}

class _UpcomingAppointment extends State<UpcomingAppointment> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget bottom = const PatientBottomNavigationBar(pageIndex: 3,);

  String token = "";

  String id = "";

  bool _visibility = true;

  late List<Widget> appointments;

  // final Map _hours = {
  //   '09:00': '09:00 - 10:00',
  //   '10:00': '10:00 - 11:00',
  //   '11:00': '11:00 - 12:00',
  //   '12:00': '12:00 - 13:00',
  //   '13:00': '13:00 - 14:00',
  //   '14:00': '14:00 - 15:00',
  //   '15:00': '15:00 - 16:00',
  //   '16:00': '16:00 - 17:00'
  // };

  Future getDetails() async {
    await UserSecureStorage.getID().then((value) => id = value!);
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    getUpcomingAppointment();
  }

  @override
  void initState() {
    appointments = [];
    if(widget.role=='doctor'){
      bottom = const DoctorBottomNavigationBar(pageIndex: 3,);
      _visibility = false;
    }
    getDetails();
    super.initState();
  }

  Future getUpcomingAppointment() async {
    http.Response response;
    try {
      if (widget.role == "patient") {
        response = await http
            .get(Uri.parse("${appointmentIP}search/userappointments/$id"));
      } else {
        // TODO: Add backend call for getting doctors upcoming appointments
        response = await http
            .get(Uri.parse("${appointmentIP}search/userappointments/$id"));
      }
      switch (response.statusCode) {
        case 200:
          var responseData = json.decode(response.body);
          for (var data in responseData) {
            Appointment appointment = Appointment();
            appointment.setDetails(data);

            HealthStatus symptoms = HealthStatus();
            final responseSymptoms = await http.get(Uri.parse(
                "${appointmentIP}search/healthstatus/${appointment.id}"));

            symptoms.setDetails(json.decode(responseSymptoms.body));
            appointment.healthStatus = symptoms;

            if (widget.role == "patient") {
              var responseName = await http.get(Uri.parse(
                  "${authenticationIP}get/name/${appointment.doctor}"));
              String name = responseName.body;

              appointments.add(AppointmentPatientTile(
                  appointment: appointment, doctor: name));
            }
            else {
              var responseName = await http.get(Uri.parse(
                  "${authenticationIP}get/name/${appointment.patient}"));

              String name = responseName.body;

              appointments.add(AppointmentDoctorTile(
                appointment: appointment,
                patient: name,
              ));

            }
            setState(() {});
          }

          break;
        case 400:
          appointments.add(Center(child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(response.body),
          )));
          setState(() {});
          break;
        default:
          var list = json.decode(response.body).values.toList();
          throw Exception(list.join("\n\n"));
      }
    } catch (e) {
      alert(e.toString().substring(11), context);
    }
  }

  Widget appointmentList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          SizedBox(
              height: 550,
              child: SizedBox(height: 200, child: _createListView()))
        ]);
  }

  Widget appointment() {
    return SingleChildScrollView(
        child: Column(children: [
      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
      const Align(
        alignment: AlignmentDirectional(-1, 0.05),
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              'Upcoming Appointments',
              style: TextStyle(fontSize: 20),
            )),
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
          leading: const AppBarItem(
            icon: CupertinoIcons.home,
            index: 3,
          ),
          title: const Text("Appointments",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: <Widget>[
            Visibility(
              visible: _visibility,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const HeathStatusPage()));
                    },
                    icon: const Icon(CupertinoIcons.plus)),
              ),
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
                  constraints:
                      const BoxConstraints(minWidth: 700, minHeight: 580),
                  decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                  child: appointment()),
            ),
          ],
        )),
        bottomNavigationBar: bottom);
  }

  Widget _createListView() {
    return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return appointments[index];
        });
  }
}
