import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;

class ViewAppointmentDetails extends StatefulWidget {
  final Appointment appointment;
  const ViewAppointmentDetails({Key? key, required this.appointment}) : super(key: key);
  @override
  State<ViewAppointmentDetails> createState() => _ViewAppointmentDetails();
}

class _ViewAppointmentDetails extends State<ViewAppointmentDetails> {

  late String patient = "";
  late String doctor = "";

  Future getNames() async {
    var response = await http.get(
        Uri.parse("${authenticationIP}get/name/${widget.appointment.doctor}"));

    doctor = response.body;

    response = await http.get(
        Uri.parse("${authenticationIP}get/name/${widget.appointment.patient}"));

    patient = response.body;

    setState(() {});
  }

  @override
  void initState() {
    getNames();
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
              title: const Text("Appointment"),
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
                        CupertinoIcons.calendar_circle_fill,
                        size: 120,
                        color: AppColors.secondary,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Appointment Details",style: TextStyle(fontSize: 24),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Doctor: $doctor",style: const TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Patient: $patient",style: const TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Date: ${widget.appointment.date}",style: const TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Time: ${widget.appointment.time}",style: const TextStyle(fontSize: 18),),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text("Patient Symptoms",style: TextStyle(fontSize: 22),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Faint: ${widget.appointment.healthStatus.faint? "Yex" : "No"}",style: const TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Fever: ${widget.appointment.healthStatus.fever? "Yex" : "No"}",style: const TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Headaches: ${widget.appointment.healthStatus.headache? "Yex" : "No"}",style: const TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Vomiting: ${widget.appointment.healthStatus.vomiting? "Yex" : "No"}",style: const TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Cough: ${widget.appointment.healthStatus.cough? "Yex" : "No"}",style: const TextStyle(fontSize: 18),),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text("Reason for Appointment",style: TextStyle(fontSize: 22),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(widget.appointment.healthStatus.description,style: const TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
