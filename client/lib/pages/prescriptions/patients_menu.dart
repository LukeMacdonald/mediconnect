import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;

class PatientsMenu extends StatefulWidget {
  const PatientsMenu({Key? key}) : super(key: key);

  @override
  State<PatientsMenu> createState() => _PatientsMenu();
}

class _PatientsMenu extends State<PatientsMenu> {

  late List<User> patients;
  late User user;

  Future getUsers() async {
    // Gets details of doctor
    await user.transferDetails();
    // Http request to get all patient ids of doctor
    var response = await http.get(
        Uri.parse("${appointmentIP}search/appointment_patients/${user.id}"),
        headers: {'Content-Type': 'application/json'});

    var responseData = json.decode(response.body);

    for (var id in responseData) {
      // Http request to get user details from id
      response = await http.get(Uri.parse("${authenticationIP}get/id/$id"),
          headers: {'Content-Type': 'application/json'});
      User patient = User();
      var userData = json.decode(response.body);
      // sets details of user object
      patient.setDetails(userData);
      // add user to list of patient
      patients.add(patient);
    }
    setState(() {});
  }

  @override
  void initState() {
    patients = [];
    user = User();
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const AppBarItem(
                icon: CupertinoIcons.home,
                index: 2,
              ),
              title: const Text("Patients",
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
            body: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (BuildContext context, int index) {
                  return PatientTile(user: patients[index], id: user.id!);
                }),
            bottomNavigationBar: const DoctorBottomNavigationBar(pageIndex: 2)));
  }
}
