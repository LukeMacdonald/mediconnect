import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePage();
}

class _DoctorHomePage extends State<DoctorHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "";

  Future setName() async {
    await UserSecureStorage.getLastName().then((value) => name = value!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setName();
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
        actions: const <Widget>[
          AppBarItem(
            icon: CupertinoIcons.bell_fill,
            index: 5,
          ),
          AppDropDown(),
        ],
      ),
      body: SizedBox(
        child: Column(
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
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 20, top: 20),
                        child: Text("Welcome Dr $name",
                            style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context).cardColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 30),
                        child: Text("Ready to Manage Your Day?",
                            style: TextStyle(
                                fontSize: 18,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  menuOption(
                                      AppColors.secondary,
                                      const Icon(
                                        CupertinoIcons.time_solid,
                                        color: Colors.blueAccent,
                                        size: 50,
                                      ),
                                      const SetAvailability(),
                                      'Set Availability',
                                      context),
                                ]),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 40, 0, 0),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  menuOption(
                                      AppColors.secondary,
                                      const Icon(
                                        CupertinoIcons.calendar_today,
                                        color: Colors.redAccent,
                                        size: 50,
                                      ),
                                      const UpcomingAppointment(role: "doctor"),
                                      'Upcoming Appointments',
                                      context),
                                ]),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 40, 0, 0),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  menuOption(
                                      AppColors.secondary,
                                      const Icon(
                                        CupertinoIcons
                                            .bubble_left_bubble_right_fill,
                                        color: Colors.deepPurpleAccent,
                                        size: 50,
                                      ),
                                      const ChatMenuDoctor(),
                                      'Contact Patient',
                                      context),
                                ]),
                          )
                        ],
                      ),
                    ]),
              )
            ]),
      ),
      bottomNavigationBar: const DoctorBottomNavigationBar(pageIndex: 0),
    );
  }
}
