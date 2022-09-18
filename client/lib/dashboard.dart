import 'package:client/add_doctor.dart';
import 'package:client/booking_by_time.dart';
import 'package:client/set_availability.dart';
import 'package:client/utilities/user.dart';
import 'package:flutter/material.dart';
import 'utilities/dashboard_utils.dart';
import 'styles/background_style.dart';

class PatientDashboard extends StatefulWidget {
  final User user;
  const PatientDashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<PatientDashboard> createState() => _PatientDashboard();
}

class _PatientDashboard extends State<PatientDashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late User user = widget.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.1,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 1.2,
                    minHeight: MediaQuery.of(context).size.height * 1),
                decoration: CustomBackground.setBackground,
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0x990F1113),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 50, 10, 0),
                            child: Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: const Color(0x66FFFFFF),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  dashboardNavbar(),
                                  dashboardUserIcon(),
                                  welcomeMessage(user.firstName),
                                  menuButtons(const Color.fromRGBO(255, 89, 99,1),
                                    const Text('Book Appointment'), const Icon( Icons.calendar_today, size: 15)
                                    ,context, MaterialPageRoute(builder: (context) => BookingByTime(user: user,))),
                                  menuButtons(const Color.fromRGBO(33, 150, 243,1),
                                      const Text('Upcoming Appointment'),const Icon( Icons.calendar_today, size: 15,)
                                      ,context, MaterialPageRoute(builder: (context) => PatientDashboard(user: user,))),
                                  menuButtons(const Color.fromRGBO(239, 141, 97,1),
                                      const Text('Contact Doctor'),const Icon( Icons.phone, size: 15,)
                                      ,context, MaterialPageRoute(builder: (context) => PatientDashboard(user: user,))),
                                  menuButtons(const Color.fromRGBO(84, 220, 180,1),
                                      const Text("View Prescriptions"), const Icon(Icons.medical_services, size: 15,)
                                      ,context, MaterialPageRoute(builder: (context) => PatientDashboard(user: user,))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
class DoctorDashboard extends StatefulWidget {
  final User user;
  const DoctorDashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<DoctorDashboard> createState() => _DoctorDashboard();
}

class _DoctorDashboard extends State<DoctorDashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late User user = widget.user;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.1,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 1.2,
                    minHeight: MediaQuery.of(context).size.height * 1),
                decoration: CustomBackground.setBackground,
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0x990F1113),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 50, 10, 0),
                            child: Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: const Color(0x66FFFFFF),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  dashboardNavbar(),
                                  dashboardUserIcon(),
                                  welcomeMessage("Dr ${user.lastName}"),
                                  menuButtons(const Color.fromRGBO(33, 150, 243,1),const Text('Upcoming Appointment'),const Icon( Icons.calendar_today, size: 15,)
                                      ,context, MaterialPageRoute(builder: (context) => DoctorDashboard(user: user,))),
                                  menuButtons(const Color.fromRGBO(239, 141, 97,1),const Text('Contact Patients'),const Icon( Icons.phone, size: 15,)
                                      ,context, MaterialPageRoute(builder: (context) => DoctorDashboard(user: user,))),
                                  menuButtons(const Color.fromRGBO(255, 89, 99,1),const Text('Change Availability'),const Icon( Icons.calendar_today, size: 15)
                                      ,context, MaterialPageRoute(builder: (context) => SetAvailability(user: user))),
                                  menuButtons(const Color.fromRGBO(84, 220, 180,1),const Text("View Patient Profile"),const Icon(Icons.person, size: 15,)
                                  ,context, MaterialPageRoute(builder: (context) => DoctorDashboard(user: user,))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}

class SuperAdminDashboard extends StatefulWidget {
  final User user;
  const SuperAdminDashboard({Key? key,required this.user}) : super(key: key);

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboard();
}

class _SuperAdminDashboard extends State<SuperAdminDashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late User user = widget.user;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.1,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 1.2,
                    minHeight: MediaQuery.of(context).size.height * 1),
                decoration: CustomBackground.setBackground,
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0x990F1113),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 50, 10, 0),
                            child: Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: const Color(0x66FFFFFF),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  dashboardNavbar(),
                                  dashboardUserIcon(),
                                  welcomeMessage("Admin ${user.firstName}"),
                                  menuButtons(const Color.fromRGBO(33, 150, 243,1),const Text('Add Doctor'),const Icon(Icons.person_add, size: 15,)
                                      ,context, MaterialPageRoute(builder: (context) => AddDoctor(user: user,))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
