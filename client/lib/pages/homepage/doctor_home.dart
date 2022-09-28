import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/imports.dart';
import '../../security/storage_service.dart';

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
                padding: const EdgeInsets.only(left: 20, bottom: 30),
                child: Text("Welcome Dr $name",
                    style: const TextStyle(fontSize: 30)),
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
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          menuOption(
                              Colors.teal,
                              const Icon(
                                CupertinoIcons.clock_fill,
                                color: Colors.white,
                                size: 50,
                              ),
                              const SetAvailability(),
                              'Set Availability',
                              context),
                          menuOption(
                              AppColors.accent,
                              const Icon(
                                CupertinoIcons.calendar_badge_plus,
                                color: Colors.white,
                                size: 50,
                              ),
                              const BookingByTime(),
                              'Update Appointments',
                              context),
                        ],
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
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              menuOption(
                                const Color.fromRGBO(33, 150, 243, 1),
                                const Icon(
                                  CupertinoIcons.calendar_today,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                const DoctorHomePage(),
                                'Upcoming Appointments',
                                context,
                              ),
                              menuOption(
                                  Colors.orangeAccent,
                                  const Icon(
                                    CupertinoIcons.bubble_left_bubble_right_fill,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const DoctorHomePage(),
                                  'Contact Patient',
                                  context),
                            ]),
                      )
                    ],
                  ),
                ]),
              )
            ]),
      bottomNavigationBar: DoctorBottomNavigationBar(pageIndex: 0),);
  }
}
