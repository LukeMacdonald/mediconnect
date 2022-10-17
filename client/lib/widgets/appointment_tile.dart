import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utilities/imports.dart';
import 'package:page_transition/page_transition.dart';

class AppointmentPatientTile extends StatefulWidget {
  final Appointment appointment;
  final String doctor;
  const AppointmentPatientTile({Key? key, required this.appointment,required this.doctor}) : super(key: key);

  @override
  State<AppointmentPatientTile> createState() => _AppointmentPatientTile();
}

class _AppointmentPatientTile extends State<AppointmentPatientTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        color: AppColors.buttonOption1Dark,
        // color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text("Doctor: ${widget.doctor}\nDate: ${widget.appointment.date}\nTime: ${widget.appointment.time}"),//Text(_appointment[index]),
            trailing: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: UpdateAppointment(
                                      appointmentDetails:widget.appointment,
                                      doctorName: widget.doctor)));
                        },
                        icon: const Icon(Icons.edit,color: Colors.white,size: 30,),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () async {
                          await deleteAppointment(widget.appointment.id);
                          if(!mounted)return;
                          navigate(const UpcomingAppointment(role: 'patient'), context);
                        },
                        icon:  const Icon(Icons.delete,color: Colors.white,size: 30,),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          navigate(ViewAppointmentDetails(appointment: widget.appointment),context);
                        },
                        icon:  const Icon(CupertinoIcons.info,color: Colors.white,size: 30,),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class AppointmentDoctorTile extends StatefulWidget {
  final Appointment appointment;
  final String patient;
  const AppointmentDoctorTile({Key? key, required this.appointment,required this.patient}) : super(key: key);

  @override
  State<AppointmentDoctorTile> createState() => _AppointmentDoctorTile();
}

class _AppointmentDoctorTile extends State<AppointmentDoctorTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        color: AppColors.buttonOption1Dark,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text("Patient: ${widget.patient}\nDate: ${widget.appointment.date}\nTime: ${widget.appointment.time}"),//Text(_appointment[index]),
            trailing: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () async {
                          await deleteAppointment(widget.appointment.id);
                          if(!mounted)return;
                          navigate(const UpcomingAppointment(role: 'doctor'), context);
                        },
                        icon:  const Icon(Icons.delete,color: Colors.white,size: 30,),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          navigate(ViewAppointmentDetails(appointment: widget.appointment),context);
                        },
                        icon:  const Icon(CupertinoIcons.info,color: Colors.white,size: 30,),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
