import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import '../prescriptions/view_prescription.dart';
import 'notifcation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "";

  Future setName() async {
    await UserSecureStorage.getFirstName().then((value) => name = value!);
    setState(() {});
  }

  @override
  void initState() {
    setName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const AppBarItem(
            icon: CupertinoIcons.home,
            index: 0,
          ),
          title: const Text("Home",
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
                            child: const Notifications()));
                  },
                  icon: const Icon(CupertinoIcons.bell_fill)),
            ),
            AppDropDown(),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                // height: 100,
                color: AppColors.secondary,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 30, top: 20),
                      child: Text("Welcome $name",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).cardColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 30),
                      child: Text("How are you feeling today?",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).cardColor)),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 10),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            menuOption(
                                AppColors.secondary,
                                const Icon(
                                  CupertinoIcons.calendar_badge_plus,
                                  color: Colors.blueAccent,
                                  size: 50,
                                ),
                                const HeathStatusPage(),
                                'Book Appointment',
                                context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            menuOption(
                                AppColors.secondary,
                                const Icon(
                                  CupertinoIcons.calendar_today,
                                  color: Colors.redAccent,
                                  size: 50,
                                ),
                                const UpcomingAppointment(role: "patient"),
                                'Upcoming Appointment',
                                context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            menuOption(
                                AppColors.secondary,
                                const Icon(
                                  CupertinoIcons.bubble_left_bubble_right_fill,
                                  color: Colors.deepPurpleAccent,
                                  size: 50,
                                ),
                                const ChatMenuPatient(),
                                'Contact Doctor',
                                context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            menuOption(
                                AppColors.secondary,
                                const Icon(
                                  Icons.medication_outlined,
                                  color: Colors.orangeAccent,
                                  size: 50,
                                ),
                                const PrescriptionList(),
                                'View Prescriptions',
                                context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])),
          ],
        ),
        bottomNavigationBar: const PatientBottomNavigationBar(pageIndex: 0));
  }
}
