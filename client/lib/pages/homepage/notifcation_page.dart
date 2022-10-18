import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/widgets/notification_tile.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  State<Notifications> createState() => _Notifications();
}

class _Notifications extends State<Notifications> {
  late String patient = "";
  late String doctor = "";

  Future getAppointment() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse("${appointmentIP}search/patient/appointments/$id"));

      switch (response.statusCode) {
        case 200:
          var responseData = json.decode(response.body);
          for (var data in responseData) {
            Appointment appointment = Appointment();
            appointment.setDetails(data);

            appointments.add(NotificationAppointmentTile(
              appointment: appointment,
            ));
            setState(() {});
          }

          break;
        case 400:
          prescriptions.add(Center(
              child: Padding(
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

    setState(() {});
  }

  String id = "";
  late List<Widget> appointments;
  late List<Widget> prescriptions;

  Future getPrescription() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse("${prescriptionIP}search/prescriptions/$id"));

      switch (response.statusCode) {
        case 200:
          var responseData = json.decode(response.body);
          for (var data in responseData) {
            Prescription prescription = Prescription();
            prescription.setDetails(data);

            prescriptions.add(NotificationPrescriptionTile(
              prescription: prescription,
            ));
            setState(() {});
          }

          break;
        case 400:
          prescriptions.add(Center(
              child: Padding(
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

    setState(() {});
  }

  Future getDetails() async {
    await UserSecureStorage.getID().then((value) => id = value!);
    getPrescription();
    getAppointment();
  }

  @override
  void initState() {
    appointments = [];
    prescriptions = [];
    getDetails();
    super.initState();
  }

  Widget generateAppointment() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          const SizedBox(height: 10),
          SizedBox(
              height: 550,
              child: SizedBox(height: 200, child: _createAppointmentListView()))
        ]));
  }

  Widget generatePrescription() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          const SizedBox(height: 10),
          SizedBox(
              height: 550,
              child:
                  SizedBox(height: 200, child: _createPrescriptionListView()))
        ]));
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
              title: const Text("Notification"),
            ),
            //_
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(children: [
                        const TabBar(
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle: TextStyle(fontSize: 14.0),
                          indicatorColor: Colors.cyan,
                          tabs: [
                            Tab(text: 'Appointment'),
                            Tab(text: 'Prescription'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                generateAppointment(),
                                generatePrescription(),
                              ]),
                        ),
                      ])),
                ))));
  }

  Widget _createAppointmentListView() {
    return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return appointments[index];
        });
  }

  Widget _createPrescriptionListView() {
    return ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          return prescriptions[index];
        });
  }
}
