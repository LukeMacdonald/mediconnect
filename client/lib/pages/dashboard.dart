import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/set_availability.dart';
import '../models/user.dart';
import '../styles/background_style.dart';
import '../widgets/dashboard.dart';
import '../widgets/navbar.dart';
import 'add_doctor.dart';
import 'booking_by_time.dart';

// Patient Dashboard
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
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start,children: [
          navbar(context,
            PatientDashboard(user: user),
            PatientDashboard(user: user),
            PatientDashboard(user: user)
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 0, 0),
            child: Text(
              'Welcome ${user.firstName}',
              style: CustomText.setCustom(
                  FontWeight.w800, 40, const Color(0xFF2190E5)),
            ),
          ),
          Container(
            width: double.infinity,
            //height: MediaQuery.of(context).size.height * 0.86,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                            child: Text(
                              'Appointment Scheduler',
                              style: CustomText.setCustom(FontWeight.bold, 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                          child: Text(
                            'Upcoming Appointments',
                            style: CustomText.setCustom(FontWeight.bold, 16),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 20, 0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 0),
                                            child: Text(
                                                'Date\n2022-10-12\n2022-12-12\n2023-01-12\n',
                                                textAlign: TextAlign.center,
                                                style: CustomText.setCustom(
                                                    FontWeight.bold, 14)),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 0),
                                            child: Text(
                                                'Time\n10:30\n13:45\n08:30',
                                                textAlign: TextAlign.center,
                                                style: CustomText.setCustom(
                                                    FontWeight.bold, 14)),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 0),
                                            child: Text(
                                                'Doctor\nDr Smith\nDr Smith\nDr William',
                                                textAlign: TextAlign.center,
                                                style: CustomText.setCustom(
                                                    FontWeight.bold, 14)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                menuOption(const Color(0xFFF77173),
                                    const Icon(Icons.calendar_today, color: Colors.white, size: 50,),
                                    BookingByTime(user: user),
                                    'Book Appointment',context),
                                menuOption(const Color(0xFF2190E5),
                                    const Icon(Icons.calendar_today, color: Colors.white,size: 50,),
                                    PatientDashboard(user: user),
                                    'Update Appointment',context),
                              ],
                            ),
                          ),
                        ],
                      ),

                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                              child: Text(
                                'Other Categories',
                                style: CustomText.setCustom(FontWeight.bold, 20),

                              ),

                          ),

                        ],

                      ),

                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          menuOption(const Color(0xFFFEA95E),
                              const Icon(Icons.medication, color: Colors.white, size: 50,),
                              PatientDashboard(user: user),
                              'View Prescriptions',context),
                          menuOption(const Color(0xFF5EDA80),
                              const Icon(Icons.phone_android, color: Colors.white,size: 50,),
                              PatientDashboard(user: user),
                              'Message \nDoctor',context),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            )
        ]
        )
    );
  }
}

// Doctor Dashboard
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
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          navbar(context,
              DoctorDashboard(user: user),
              DoctorDashboard(user: user),
              DoctorDashboard(user: user)
          ),
          Container(
            width: double.infinity,
            height: 550,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  //dashboardUserIcon(),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                    child: Text(
                      'Welcome Dr ${user.lastName}',
                      style: CustomText.setCustom(
                          FontWeight.w800, 40, const Color(0xFF2190E5)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                          child: Text(
                            'Appointment Scheduler',
                            style: CustomText.setCustom(FontWeight.bold, 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                        child: Text(
                          'Upcoming Appointments',
                          style: CustomText.setCustom(FontWeight.bold, 16),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 20, 0),
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
                                          child: Text(
                                              'Date\n2022-10-12\n2022-12-12\n2023-01-12\n',
                                              textAlign: TextAlign.center,
                                              style: CustomText.setCustom(
                                                  FontWeight.bold, 14)),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
                                          child: Text(
                                              'Time\n10:30\n13:45\n08:30',
                                              textAlign: TextAlign.center,
                                              style: CustomText.setCustom(
                                                  FontWeight.bold, 14)),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
                                          child: Text(
                                              'Patient\nJohn Smith\nSuzie Joe\nRobin Schmitt ',
                                              textAlign: TextAlign.center,
                                              style: CustomText.setCustom(
                                                  FontWeight.bold, 14)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        menuOption(const Color(0xFFF77173),
                            const Icon(Icons.access_time_rounded, color: Colors.white, size: 50,),
                            SetAvailability(user: user),
                            'Change Availability',context),
                        menuOption(const Color(0xFF2190E5),
                            const Icon(Icons.calendar_today, color: Colors.white,size: 50,),
                            PatientDashboard(user: user),
                            'Update Appointment',context),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 5),
                            child: Text(
                              'Popular Categories',
                              style: CustomText.setCustom(FontWeight.bold, 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        menuOption(const Color(0xFFFEA95E),
                            const Icon(Icons.person, color: Colors.white, size: 50,),
                            DoctorDashboard(user: user),
                            'View Patient Profile',context),
                        menuOption(const Color(0xFF5EDA80),
                            const Icon(Icons.phone_android, color: Colors.white,size: 50,),
                            DoctorDashboard(user: user),
                            'Message \nPatient',context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}

// Admin Dashboard
class SuperAdminDashboard extends StatefulWidget {
  final User user;
  const SuperAdminDashboard({Key? key, required this.user}) : super(key: key);
  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboard();
}
class _SuperAdminDashboard extends State<SuperAdminDashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late User user = widget.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          navbar(context,
            SuperAdminDashboard(user: user),
            SuperAdminDashboard(user: user),
            SuperAdminDashboard(user: user),
          ),
          Container(
              width: double.infinity,
              height: 550,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    //dashboardUserIcon(),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                      child: Text(
                        'Welcome Admin ${user.firstName}',
                        style: CustomText.setCustom(
                            FontWeight.w800, 40, const Color(0xFF2190E5)),
                      ),
                    ),
                    Padding(

                      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          menuOption(const Color(0xFFF77173),
                              const Icon(Icons.person_add, color: Colors.white, size: 50,),
                              AddDoctor(user: user),
                              'Add Doctor',context),
                          menuOption(Colors.lightBlue,
                              const Icon(Icons.person_add, color: Colors.white, size: 50,),
                              AddDoctor(user: user),
                              'Add Admin',context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          )]));
  }
}
