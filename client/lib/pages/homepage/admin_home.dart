import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/booking/set_availability.dart';
import '../../models/user.dart';
import '../../widgets/dashboard.dart';
import '../../widgets/navbar.dart';
import '../registration/add_doctor.dart';

class AdminHomePage extends StatelessWidget {
  static Route route(User user) => MaterialPageRoute(
      builder: (context) => AdminHomePage(
        user: user,
      ));
  const AdminHomePage({Key? key, required this.user}) : super(key: key);
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
                child: Text("Welcome Dr ${user.lastName}",style:const TextStyle(fontSize: 30)),
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
                                  Colors.green,
                                  const Icon(
                                    CupertinoIcons.person_add,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  AddDoctor(user: user),
                                  'Add Doctor',
                                  context),
                              menuOption(
                                  Colors.lightBlueAccent,
                                  const Icon(
                                    CupertinoIcons.person_add,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  AdminHomePage(user: user),
                                  'Add Admin',
                                  context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]));
  }
}