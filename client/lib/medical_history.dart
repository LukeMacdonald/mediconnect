import 'package:client/dashboard.dart';
import 'package:client/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import "dashboard.dart";
import 'package:client/styles/custom_styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MedicalHistory extends StatefulWidget {
  final User user;
  const MedicalHistory({Key? key, required this.user}) : super(key: key);

  @override
  State<MedicalHistory> createState() => _MedicalHistory(user);
}

class _MedicalHistory extends State<MedicalHistory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  User user;

  _MedicalHistory(this.user);

  TextEditingController ill = TextEditingController();
  TextEditingController med = TextEditingController();
  TextEditingController dis = TextEditingController();

  UserMedicalHistory userHistory = UserMedicalHistory();

  bool? _disabled = true;

  List<String> presetIllnesses = [
    'Cancer',
    'Diabetes',
    'Cardiac Disease',
    'Asthma',
    'Alzheimer\'s',
    'Depression',
  ];

  List<String> medications = [];
  List<String> presetDisabilities = [
    'Hearing Impairment',
    'Vision Impairment',
    'Autism',
    'Mobility Disability ',
    'Cerebral Palsy'
  ];

  List<Object?> selectedMeds = [];

  String url = "URL to save medical profile";
  String url2 = "URL to medications";
  String url3 = "URL to illnesses";
  String ur4 = "URL to disabilities";
  String url5 = "URL to get user id";

  Future save() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PatientDashboard(user:user)));

    // await http.post(Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode({
    //       'id': user.id,
    //       'smokes': userHistory.smoke,
    //       'drinks': userHistory.drink,
    //       'medication': userHistory.medications,
    //     }));
    // ADD MORE LATER
  }

  Widget checks() {
    return Wrap(children: [
      const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 15),
        child: Text(
          'Are you currently taking any medication?',
          style: CustomTextStyle.nameOfTextStyle,
        ),
      ),
      CustomRadioButton(
        spacing: 50,
        buttonLables: const ['Yes', 'No'],
        buttonValues: const ['Yes', 'No'],
        radioButtonValue: (value) {
          if (value == 'Yes') {
            userHistory.medication = true;
            setState(() {
              _disabled = false;
            });
          } else {
            userHistory.medication = false;
            setState(() {
              _disabled = true;
            });
          }
        },
        enableButtonWrap: true,
        elevation: 5,
        autoWidth: true,
        enableShape: true,
        unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
        selectedBorderColor: const Color.fromRGBO(57, 210, 192, 1),
        unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
        selectedColor: const Color.fromRGBO(57, 210, 192, 1),
        padding: 5,
      ),
      Wrap(
        spacing: 30,
        children: [
          CustomCheckBoxGroup(
            buttonLables: medications,
            buttonValuesList: medications,
            checkBoxButtonValues: (values) {
              userHistory.medications = values;
            },
            enableButtonWrap: true,
            elevation: 5,
            width: 150,
            enableShape: true,
            unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
            selectedBorderColor: const Color.fromRGBO(57, 210, 192, 1),
            unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
            selectedColor: const Color.fromRGBO(57, 210, 192, 1),
            padding: 5,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(60, 10, 10, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFECECEC),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                child: TextFormField(
                  enabled: !_disabled!,
                  controller: med,
                  decoration: const InputDecoration(
                    hintText: 'What Medications Do You Take?',
                    hintStyle: CustomTextStyle.nameOfTextStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                  ),
                  style: CustomTextStyle.nameOfTextStyle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: FloatingActionButton(
              onPressed: () {
                if (med.text != "What Medications Do You Take?" &&
                    med.text != "" &&
                    !userHistory.medications.contains(ill.text)) {
                  setState(() {
                    medications.add(med.text);
                    med.clear();
                  });
                }
              },
              backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
              elevation: 8,
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 15),
            child: Text(
              'Do you smoke?',
              style: CustomTextStyle.nameOfTextStyle,
            ),
          ),
          CustomRadioButton(
            buttonLables: const ['Yes', 'No'],
            buttonValues: const ['Yes', 'No'],
            radioButtonValue: (value) => {
              if (value == 'Yes')
                {userHistory.smoke = true}
              else
                {userHistory.smoke = false},
            },
            enableButtonWrap: true,
            elevation: 5,
            autoWidth: true,
            enableShape: true,
            spacing: 50,
            unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
            selectedBorderColor: const Color.fromRGBO(57, 210, 192, 1),
            unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
            selectedColor: const Color.fromRGBO(57, 210, 192, 1),
            padding: 5,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 15),
            child: Text(
              'Do you drink alcohol?',
              style: CustomTextStyle.nameOfTextStyle,
            ),
          ),
          CustomRadioButton(
            buttonLables: const ['Yes', 'No'],
            buttonValues: const ['Yes', 'No'],
            radioButtonValue: (value) => {
              if (value == 'Yes')
                {userHistory.drink = true}
              else
                {userHistory.drink = false},
            },
            enableButtonWrap: true,
            elevation: 5,
            spacing: 50,
            autoWidth: true,
            enableShape: true,
            unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
            selectedBorderColor: const Color.fromRGBO(57, 210, 192, 1),
            unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
            selectedColor: const Color.fromRGBO(57, 210, 192, 1),
            padding: 5,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
            child: Text(
              'Do you have any illnesses?',
              style: CustomTextStyle.nameOfTextStyle,
            ),
          ),
        ],
      )
    ]);
  }

  Widget submit() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
              save(),
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 50),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: const Color.fromRGBO(57, 210, 192, 1)),
            child: Text('Submit',
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ))));
  }

  Widget illnesses() {
    return Wrap(
        spacing: 30,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          CustomCheckBoxGroup(
            buttonLables: presetIllnesses,
            buttonValuesList: presetIllnesses,
            checkBoxButtonValues: (values) {
              userHistory.userIllnesses = values;
            },
            enableButtonWrap: true,
            elevation: 5,
            width: 150,
            enableShape: true,
            unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
            selectedBorderColor: const Color.fromRGBO(57, 210, 192, 1),
            unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
            selectedColor: const Color.fromRGBO(57, 210, 192, 1),
            padding: 5,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(60, 10, 10, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFECECEC),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                child: TextFormField(
                    autofocus: true,
                    obscureText: false,
                    controller: ill,
                    decoration: const InputDecoration(
                      hintText: 'Any Other not on list?',
                      hintStyle: CustomTextStyle.nameOfTextStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: CustomTextStyle.nameOfTextStyle),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: FloatingActionButton(
              onPressed: () {
                if (ill.text != "Any Other not on list?" &&
                    !presetIllnesses.contains(ill.text)) {
                  setState(() {
                    presetIllnesses.add(ill.text);
                    ill.clear();
                  });
                }
              },
              backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
              elevation: 8,
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 20),
            child: Text(
              'Do you have any Disabilities?',
              style: CustomTextStyle.nameOfTextStyle,
            ),
          ),
        ]);
  }

  Widget disabilities() {
    return Wrap(spacing: 30, alignment: WrapAlignment.center, children: [
      CustomCheckBoxGroup(
        buttonLables: presetDisabilities,
        buttonValuesList: presetDisabilities,
        checkBoxButtonValues: (values) {
          userHistory.userDisabilities = values;
        },
        enableButtonWrap: true,
        elevation: 5,
        width: 150,
        enableShape: true,
        unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
        selectedBorderColor: const Color.fromRGBO(57, 210, 192, 1),
        unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
        selectedColor: const Color.fromRGBO(57, 210, 192, 1),
        padding: 5,
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFECECEC),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
            child: TextFormField(
              autofocus: true,
              controller: dis,
              decoration: const InputDecoration(
                hintText: 'Any Other not on list?',
                hintStyle: CustomTextStyle.nameOfTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
              ),
              style: CustomTextStyle.nameOfTextStyle,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: FloatingActionButton(
          onPressed: () {
            if (dis.text != "Any Other not on list?" &&
                !presetDisabilities.contains(dis.text)) {
              setState(() {
                presetDisabilities.add(dis.text);
                dis.clear();
              });
            }
          },
          backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
          elevation: 8,
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1.1,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 1.2,
                minHeight: MediaQuery.of(context).size.height * 1),
            decoration: const BoxDecoration(
              color: Color(0xFF14181B),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/background.jpeg'),
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0x990F1113),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Container(
                        width: 700,
                        decoration: BoxDecoration(
                          color: const Color(0x66FFFFFF),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text(
                                'Medical History',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    30, 0, 30, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 10),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0),
                                                  bottomRight:
                                                  Radius.circular(0),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: checks(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 0),
                                        child: illnesses(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 0),
                                        child: disabilities(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 70, 5, 30),
                                child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    constraints: const BoxConstraints(
                                      maxWidth: 250,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 223, 223, 223),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: submit()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}


