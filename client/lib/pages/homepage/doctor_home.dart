import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/booking/booking_by_time.dart';
import 'package:nd_telemedicine/pages/booking/set_availability.dart';
import 'package:nd_telemedicine/styles/theme.dart';
import '../../models/user.dart';
import '../../widgets/dashboard.dart';
import '../../widgets/navbar.dart';

class DoctorHomePage extends StatelessWidget {
  static Route route(User user) => MaterialPageRoute(
      builder: (context) => DoctorHomePage(
            user: user,
          ));
  const DoctorHomePage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarItem(
            icon: CupertinoIcons.home,
            index: 0,
            user: user,
          ),
          title: const Text("Home",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,
              user: user,
            ),
            const SizedBox(width: 20),
            AppBarItem(
              icon: CupertinoIcons.settings_solid,
              index: 5,
              user: user,
            ),
            const SizedBox(width: 20),
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
                child: Text("Welcome Dr ${user.lastName}",
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
                              SetAvailability(user: user),
                              'Set Availability',
                              context),
                          menuOption(
                              AppColors.accent,
                              const Icon(
                                CupertinoIcons.calendar_badge_plus,
                                color: Colors.white,
                                size: 50,
                              ),
                              BookingByTime(user: user),
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
                                DoctorHomePage(user: user),
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
                                  DoctorHomePage(user: user),
                                  'Contact Patient',
                                  context),
                            ]),
                      )
                    ],
                  ),
                ]),
              )
            ]),
      bottomNavigationBar: DoctorBottomNavigationBar(pageIndex: 0,user: user,),);
  }
}
