import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "";

  Future setName() async {
    await UserSecureStorage.getFirstName().then((value) => name = value!);
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
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 20, top: 20),
                        child: Text("Welcome $name",
                            style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context).cardColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 30),
                        child: Text("System Management",
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
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              menuOption(
                                  AppColors.secondary,
                                  const Icon(
                                    CupertinoIcons.person_add,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                  const AddDoctor(),
                                  'Add Doctor',
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              menuOption(
                                  AppColors.secondary,
                                  const Icon(
                                    CupertinoIcons.person_badge_minus,
                                    color: Colors.redAccent,
                                    size: 50,
                                  ),
                                  const RemoveProfile(role: "doctor"),
                                  'Remove Doctor',
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              menuOption(
                                  AppColors.secondary,
                                  const Icon(
                                    CupertinoIcons.person_badge_minus,
                                    color: Colors.orangeAccent,
                                    size: 50,
                                  ),
                                  const RemoveProfile(role: "patient"),
                                  'Remove Patient',
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
