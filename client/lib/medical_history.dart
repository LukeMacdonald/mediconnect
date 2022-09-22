import 'package:client/dashboard.dart';
import 'package:client/styles/background_style.dart';
import 'package:client/utilities/custom_widgets.dart';
import 'package:client/utilities/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:page_transition/page_transition.dart';
import "dashboard.dart";
import 'package:client/styles/custom_styles.dart';

class MedicalHistory extends StatefulWidget {
  final User user;
  const MedicalHistory({Key? key, required this.user}) : super(key: key);

  @override
  State<MedicalHistory> createState() => _MedicalHistory();
}

class _MedicalHistory extends State<MedicalHistory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late User user = widget.user;

  _MedicalHistory();

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

  Future save() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PatientDashboard(user: user)));
  }

  Widget smokes() {
    return Wrap(children: [
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
        unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
        selectedBorderColor: const Color(0xFF2190E5),
        unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
        selectedColor: const Color(0xFF2190E5),
        padding: 5,
      )
    ]);
  }

  Widget drinks() {
    return Wrap(children: [
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

        autoWidth: true,
        enableShape: true,
        unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
        selectedBorderColor: const Color(0xFF2190E5),
        unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
        selectedColor: const Color(0xFF2190E5),
        padding: 5,
      )
    ]);
  }

  Widget meds() {
    return Wrap(children: [
      CustomRadioButton(
        buttonLables: const ['Yes', 'No'],
        buttonValues: const ['Yes', 'No'],
        radioButtonValue: (value) {
          if (value == 'Yes') {
            userHistory.medication = true;
            setState(() {
              _disabled = false;
            });
          } else {
            userHistory.medications.clear();
            medications.clear();
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
        selectedBorderColor: const Color(0xFF2190E5),
        unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
        selectedColor: const Color(0xFF2190E5),
        padding: 5,
      ),
      Wrap(spacing: 30, children: [
        pad(0, 20, 0, 0),
        Row(mainAxisSize: MainAxisSize.max, children: [
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
              child: TextFormField(
                enabled: !_disabled!,
                controller: med,
                decoration: InputDecoration(
                  labelText: 'Enter Medication',
                  labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                  hintText: 'Enter Name of Medication...',
                  hintStyle:
                      CustomText.setCustom(FontWeight.w500, 14.0, Colors.grey),
                  enabledBorder: CustomOutlineInputBorder.custom,
                  focusedBorder: CustomOutlineInputBorder.custom,
                  errorBorder: CustomOutlineInputBorder.custom,
                  focusedErrorBorder: CustomOutlineInputBorder.custom,
                ),
                style: CustomText.setCustom(FontWeight.w500, 14),
              ),
            ),
          ),
          FloatingActionButton(
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
            backgroundColor: const Color(0xFF2190E5),
            elevation: 8,
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

        ]),
        const Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20)),
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
          selectedBorderColor: const Color(0xFF2190E5),
          unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
          selectedColor: const Color(0xFF2190E5),
          padding: 5,
        ),
      ])
    ]);
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
            autoWidth: true,
            enableShape: true,
            unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
            selectedBorderColor: const Color(0xFF2190E5),
            unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
            selectedColor: const Color(0xFF2190E5),
            padding: 5,
          ),
          pad(0, 20, 0, 0),
          Row(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                child: TextFormField(
                  controller: ill,
                  decoration: InputDecoration(
                    labelText: 'Any Other not on list?',
                    labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                    hintText: 'Enter Name of Medication...',
                    hintStyle: CustomText.setCustom(
                        FontWeight.w500, 14.0, Colors.grey),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: CustomText.setCustom(FontWeight.w500, 14),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                if (ill.text != "Any Other not on list?" &&
                    !presetIllnesses.contains(ill.text)) {
                  setState(() {
                    presetIllnesses.add(ill.text);
                    ill.clear();
                  });
                }
              },
              backgroundColor: const Color(0xFF2190E5),
              elevation: 8,
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ]),
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
        autoWidth: true,
        enableShape: true,
        unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
        selectedBorderColor: const Color(0xFF2190E5),
        unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
        selectedColor: const Color(0xFF2190E5),
        padding: 5,
      ),
      pad(0, 20, 0, 0),
      Row(mainAxisSize: MainAxisSize.max, children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
            child: TextFormField(
              controller: dis,
              decoration: InputDecoration(
                labelText: 'Any Other not on list?',
                labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                hintText: 'Enter Name of Disability...',
                hintStyle:
                    CustomText.setCustom(FontWeight.w500, 14.0, Colors.grey),
                enabledBorder: CustomOutlineInputBorder.custom,
                focusedBorder: CustomOutlineInputBorder.custom,
                errorBorder: CustomOutlineInputBorder.custom,
                focusedErrorBorder: CustomOutlineInputBorder.custom,
              ),
              style: CustomText.setCustom(FontWeight.w500, 14),
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            if (dis.text != "Any Other not on list?" &&
                !presetDisabilities.contains(dis.text)) {
              setState(() {
                presetDisabilities.add(dis.text);
                dis.clear();
              });
            }
          },
          backgroundColor: const Color(0xFF2190E5),
          elevation: 8,
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ]),
    ]);
  }

  Widget button(Color color, String message) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
              constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: PatientDashboard(user: user)));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(230, 50),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: color),
                  child: Text(
                    message,
                    style:
                        CustomText.setCustom(FontWeight.w900, 16, Colors.white),
                  )))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(mainAxisSize: MainAxisSize.max, children: [
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 10),
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2190E5),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(1000),
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 30,
                                          color: Colors.black,
                                        )),
                                  ]),
                            )),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Text('Medical History',
                                    style: CustomText.setCustom(FontWeight.w800,
                                        40, const Color(0xFF2190E5))),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 70, 0),
                                    child: Text(
                                      'Please enter your Medical History details below:',
                                      style: CustomText.setCustom(
                                          FontWeight.w900, 17.0),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you smoke?',
                            style: CustomText.setCustom(FontWeight.w600, 16.0),
                          ),
                        ),
                        smokes(),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you drink?',
                            style: CustomText.setCustom(FontWeight.w600, 16.0),
                          ),
                        ),
                        drinks(),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you take any medication?',
                            style: CustomText.setCustom(FontWeight.w600, 16.0),
                          ),
                        ),
                        meds(),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you have any Illnesses?',
                            style: CustomText.setCustom(FontWeight.w600, 16.0),
                          ),
                        ),
                        illnesses(),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you have any Disabilities?',
                            style: CustomText.setCustom(FontWeight.w600, 16.0),
                          ),
                        ),
                        disabilities(),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                        ),
                        button(const Color(0xFF2190E5), "Submit"),
                      ])
                    ]))));
  }
}
