import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;

class PrescriptionList extends StatefulWidget {
  const PrescriptionList({Key? key}) : super(key: key);
  @override
  State<PrescriptionList> createState() => _PrescriptionList();
}

class _PrescriptionList extends State<PrescriptionList> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String id = "";
  late List<Widget> prescriptions;

  Future getDetails() async {
    await UserSecureStorage.getID().then((value) => id = value!);
    getPrescriptions();
  }

  Future getPrescriptions() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse("$SERVERDOMAIN/medical/prescriptions/${int.parse(id)}"));

      switch (response.statusCode) {
        case 200:
          var responseData = json.decode(response.body);

          for (var data in responseData) {
            Prescription prescription = Prescription();
            prescription.setDetails(data);
            prescriptions.add(PrescriptionTile(
              prescription: prescription,
            ));
            setState(() {});
          }
          break;
        case 400:
          var responseData = response.body;
          prescriptions.add(Center(child: Padding(padding: const EdgeInsets.all(20.0), child: Text(responseData))));
          setState(() {});
          break;
        default:
          var list = json.decode(response.body).values.toList();
          throw Exception(list.join("\n\n"));
      }
    } catch (e) {
      alert(e.toString().substring(11), context);
    }
  }

  Widget prescriptionList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          SizedBox(
              height: 550,
              child: SizedBox(height: 200, child: _createListView()))
        ]);
  }

  Widget prescription() {
    return SingleChildScrollView(
        child: Column(children: [
      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
      const Align(
        alignment: AlignmentDirectional(-1, 0.05),
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              'Your Prescriptions',
              style: TextStyle(fontSize: 20),
            )),
      ),
      prescriptionList(),
    ]));
  }

  Widget _createListView() {
    return ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          return prescriptions[index];
        });
  }

  @override
  void initState() {
    prescriptions = [];
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const AppBarItem(
            icon: CupertinoIcons.home,
            index: 3,
          ),
          title: const Text("Prescriptions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: const <Widget>[
            AppDropDown(),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 20,
                decoration: const BoxDecoration(color: Colors.transparent)),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 700, minHeight: 580),
                  decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                  child: prescription()),
            ),
          ],
        )),
        bottomNavigationBar: const PatientBottomNavigationBar(pageIndex: 2));
  }


}
