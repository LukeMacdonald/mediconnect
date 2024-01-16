import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;

class AddPrescription extends StatefulWidget {
  final int patientId;
  const AddPrescription({Key? key, required this.patientId}) : super(key: key);

  @override
  State<AddPrescription> createState() => _AddPrescription();
}

class _AddPrescription extends State<AddPrescription> {
  Prescription prescription = Prescription();

  Future save() async {
    String id = "";
    await UserSecureStorage.getID().then(((value) => id = value!));

    await http.post(Uri.parse("$SERVERDOMAIN/medical/prescription"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'patientId': widget.patientId,
          'doctorId': int.parse(id),
          'name': prescription.name,
          'repeats': prescription.repeats,
          'dosage': prescription.dosage,
        }));

    if (!mounted) return;
    navigate(const DoctorHomePage(), context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 54,
              leading: Align(
                alignment: Alignment.centerRight,
                child: IconBackground(
                  icon: CupertinoIcons.back,
                  onTap: () {
                    if (!mounted) return;
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ),
              title: const Text("Prescriptions"),
            ),
            body: SizedBox(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          'Add Prescription',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 20),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 70, 0),
                              child: Text(
                                'Please prescription details below:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Material(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextFormField(
                                          obscureText: false,
                                          onChanged: (val) {
                                            prescription.name = val;
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Name',
                                            labelStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText:
                                                'Enter name of prescription',
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          keyboardType: TextInputType.name,
                                        )))))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Material(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextFormField(
                                          obscureText: false,
                                          onChanged: (val) {
                                            prescription.dosage =
                                                double.parse(val);
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Dosage',
                                            labelStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText:
                                                'Enter dosage of prescription',
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          keyboardType: TextInputType.number,
                                        )))))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Material(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextFormField(
                                          obscureText: false,
                                          onChanged: (val) {
                                            prescription.repeats =
                                                int.parse(val);
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Repeats',
                                            labelStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Enter Number of Repeats',
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          keyboardType: TextInputType.number,
                                        )))))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 60),
                      child: SubmitButton(
                        color: AppColors.secondary,
                        message: "Submit",
                        width: 100,
                        height: 60,
                        onPressed: () async {
                          save();
                        },
                      ),
                    ),
                  ]),
                ),
              ]),
            )));
  }
}
