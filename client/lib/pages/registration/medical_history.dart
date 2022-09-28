import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:nd_telemedicine/pages/homepage/home_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../models/medical_history.dart';
import '../../models/user.dart';
import '../../styles/custom_styles.dart';
import '../../styles/textformfield_style.dart';
import '../../styles/theme.dart';

class MedicalHistory extends StatefulWidget {
  final User user;
  const MedicalHistory({Key? key, required this.user}) : super(key: key);

  @override
  State<MedicalHistory> createState() => _MedicalHistory();
}

class _MedicalHistory extends State<MedicalHistory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late User user = widget.user;

  TextEditingController ill = TextEditingController();
  TextEditingController med = TextEditingController();
  TextEditingController dis = TextEditingController();
  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  TextEditingController textFieldController3 = TextEditingController();

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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Medication',style:TextStyle(fontSize: 30),),
            content: SizedBox(
              height:300,
            child:Column(
                children:[
                  TextField(
                    onChanged: (value) {},
                    controller: textFieldController,
                    decoration: CustomTextFormDecoration.setDecoration("Name"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: TextField(
                      onChanged: (value) {},
                      controller: textFieldController2,
                      decoration: CustomTextFormDecoration.setDecoration("Dosage"),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: TextField(
                      onChanged: (value) {},
                      controller: textFieldController3,
                      decoration: CustomTextFormDecoration.setDecoration("# Repeats"),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: TextButton(
                      onPressed: () {
                        textFieldController.clear();
                        textFieldController2.clear();
                        textFieldController3.clear();
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK',style:TextStyle(fontSize: 16,color:AppColors.secondary)),
                    ),
                  ),
                ]
            )
            )
          );
        });
  }

  Future save() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(user: user)));
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
        Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                child: TextFormField(
                  enabled: !_disabled!,
                  controller: med,
                  decoration: const InputDecoration(
                    labelText: 'Enter Medication',
                    labelStyle: TextStyle(fontSize: 16),
                    hintText: 'Enter Name of Medication...',
                    hintStyle:TextStyle(fontSize: 16),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: "medications",
              onPressed: () {
                _displayTextInputDialog(context);
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
        ),
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
          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                  child: TextFormField(
                    controller: ill,
                    decoration: const InputDecoration(
                      labelText: 'Any Other not on list?',
                      labelStyle: const TextStyle(fontSize: 16),
                      hintText: 'Enter Name of Medication...',
                      hintStyle: const TextStyle(fontSize: 16),
                      enabledBorder: CustomOutlineInputBorder.custom,
                      focusedBorder: CustomOutlineInputBorder.custom,
                      errorBorder: CustomOutlineInputBorder.custom,
                      focusedErrorBorder: CustomOutlineInputBorder.custom,
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              FloatingActionButton(
                heroTag: "illnesses",
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
        autoWidth: true,
        enableShape: true,
        unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
        selectedBorderColor: const Color(0xFF2190E5),
        unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
        selectedColor: const Color(0xFF2190E5),
        padding: 5,
      ),

      Padding(
        padding: const EdgeInsets.only(top:20),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
              child: TextFormField(
                controller: dis,
                decoration: const InputDecoration(
                  labelText: 'Any Other not on list?',
                  labelStyle: TextStyle(fontSize: 16),
                  hintText: 'Enter Name of Disability...',
                  hintStyle:
                  TextStyle(fontSize: 16),
                  enabledBorder: CustomOutlineInputBorder.custom,
                  focusedBorder: CustomOutlineInputBorder.custom,
                  errorBorder: CustomOutlineInputBorder.custom,
                  focusedErrorBorder: CustomOutlineInputBorder.custom,
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: "disabilities",
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
      ),
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
                            child: HomePage(user: user)));
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
                    const TextStyle(fontSize: 16,fontWeight: FontWeight.w900),
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
                            children: const [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Text('Medical History',style:TextStyle(fontSize: 30,color:AppColors.secondary,fontWeight: FontWeight.w800),)
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Expanded(
                                child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 70, 0),
                                    child: Text(
                                      'Please enter your Medical History details below:',
                                      style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you smoke?',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        smokes(),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you drink?',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        drinks(),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you take any medication?',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        meds(),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you have any Illnesses?',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        illnesses(),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: Text(
                            'Do you have any Disabilities?',
                            style: const TextStyle(fontSize: 16),
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
