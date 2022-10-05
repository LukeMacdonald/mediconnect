import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    await UserSecureStorage.getLastName().then((value) => name = value!);
  }
  @override
  void initState(){
    setName();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
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
                child: Text("Welcome Dr $name",style:const TextStyle(fontSize: 30)),
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
                                  const AddDoctor(),
                                  'Add Doctor',
                                  context),
                              menuOption(
                                  Colors.lightBlueAccent,
                                  const Icon(
                                    CupertinoIcons.person_add,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const AdminHomePage(),
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