import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utilities/imports.dart';

class HomePage extends StatefulWidget {


  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();

}
class _HomePage extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "";

  Future setName() async {
    await UserSecureStorage.getLastName().then((value) => name = value!);
  }
  @override
  void initState(){
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
          actions: const <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,
            ),
            AppDropDown(),

          ],
        ),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,bottom: 30),
                child: Text("Welcome $name",style:const TextStyle(fontSize: 30)),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              menuOption(
                                  const Color(0xFFF77173),
                                  const Icon(
                                    CupertinoIcons.calendar_badge_plus,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const HeathStatusPage(),
                                  'Book Appointment',
                                  context),
                              menuOption(
                                  const Color(0xFF2190E5),
                                  const Icon(
                                    CupertinoIcons.calendar,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const UpcomingAppointment(role:"patient"),
                                  'Upcoming Appointment',
                                  context),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                          child:
                                menuOption(
                                    Colors.orangeAccent,
                                    const Icon(
                                      CupertinoIcons.bubble_left_bubble_right_fill,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    const ChatMenuPatient(),
                                    'Contact Patient',
                                    context),
                        )]),
                        ])
                    ),
                  ],
                ),
        bottomNavigationBar:const PatientBottomNavigationBar(pageIndex: 0));
  }
}


