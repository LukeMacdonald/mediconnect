import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../booking/health_status.dart';
import '../../widgets/dashboard.dart';
import '../../widgets/navbar.dart';

class HomePage extends StatelessWidget {
  static Route route(User user) => MaterialPageRoute(
      builder: (context) => HomePage(
            user: user,
          ));
  const HomePage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarItem(
            icon: CupertinoIcons.home,
            index: 0, user: user,
          ),
          title: const Text("Home",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5, user: user,
            ),
            const SizedBox(width: 20),
            AppBarItem(
              icon: CupertinoIcons.settings_solid,
              index: 5, user: user,
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
                padding: const EdgeInsets.only(left: 20,bottom: 30),
                child: Text("Welcome ${user.firstName}",style:const TextStyle(fontSize: 30)),
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
                                  HeathStatusPage(user: user),
                                  'Book Appointment',
                                  context),
                              menuOption(
                                  const Color(0xFF2190E5),
                                  const Icon(
                                    CupertinoIcons.calendar,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  HomePage(user: user),
                                  'Update Appointment',
                                  context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),bottomNavigationBar:CustomBBottomNavigationBar(pageIndex: 0,user:user));
  }
}
