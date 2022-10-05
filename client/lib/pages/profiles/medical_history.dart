import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:page_transition/page_transition.dart';
import '../../utilities/imports.dart';

enum SingingCharacter { yes, no }

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({Key? key}) : super(key: key);

  @override
  State<MedicalHistory> createState() => _MedicalHistory();
}

class _MedicalHistory extends State<MedicalHistory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController ill = TextEditingController();
  TextEditingController med = TextEditingController();
  TextEditingController dis = TextEditingController();
  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  TextEditingController textFieldController3 = TextEditingController();

  UserMedicalHistory userHistory = UserMedicalHistory();

  SingingCharacter? _smokes = SingingCharacter.no;
  SingingCharacter? _medications = SingingCharacter.no;
  SingingCharacter? _drinks = SingingCharacter.no;

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
              title: const Text(
                'Add Medication',
                style: TextStyle(fontSize: 30),
              ),
              content: SizedBox(
                  height: 300,
                  child: Column(children: [
                    TextField(
                      onChanged: (value) {},
                      controller: textFieldController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        onChanged: (value) {},
                        controller: textFieldController2,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        onChanged: (value) {},
                        controller: textFieldController3,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextButton(
                        onPressed: () {
                          textFieldController.clear();
                          textFieldController2.clear();
                          textFieldController3.clear();
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.secondary)),
                      ),
                    ),
                  ])));
        });
  }

  Future save() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Widget meds() {
    return Wrap(children: [
      Wrap(spacing: 30, children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: Material(
                      elevation: 5,
                      color: Theme.of(context).dividerColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                        child: TextFormField(
                          enabled: !_disabled!,
                          controller: med,
                          decoration: const InputDecoration(
                            labelText: 'Enter Medication',
                            labelStyle: TextStyle(fontSize: 16),
                            hintText: 'Enter Name of Medication...',
                            hintStyle: TextStyle(fontSize: 16),
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ))),
            ),
            GlowingActionButton(
              color: Colors.teal,
              icon: CupertinoIcons.add,
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
            )
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
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          CustomCheckBoxGroup(
            buttonLables: presetIllnesses,
            buttonValuesList: presetIllnesses,
            checkBoxButtonValues: (values) {
              userHistory.userIllnesses = values;
            },
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
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: Material(
                    elevation: 5,
                    color: Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                      child: TextFormField(
                        controller: ill,
                        decoration: const InputDecoration(
                          labelText: 'Any Other not on list?',
                          labelStyle: TextStyle(fontSize: 16),
                          hintText: 'Enter Name of Illness..',
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              GlowingActionButton(
                color: Colors.teal,
                icon: CupertinoIcons.add,
                onPressed: () {
                  if (ill.text != "Any Other not on list?" &&
                      !presetIllnesses.contains(ill.text)) {
                    setState(() {
                      presetIllnesses.add(ill.text);
                      ill.clear();
                    });
                  }
                },
              )
            ]),
          ),
        ]);
  }

  Widget disabilities() {
    return Wrap(spacing: 30, alignment: WrapAlignment.start, children: [
      CustomCheckBoxGroup(
        buttonLables: presetDisabilities,
        buttonValuesList: presetDisabilities,
        checkBoxButtonValues: (values) {
          userHistory.userDisabilities = values;
        },
        enableButtonWrap: false,
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
        padding: const EdgeInsets.only(top: 20),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: Material(
                    elevation: 5,
                    color: Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                      child: TextFormField(
                        controller: dis,
                        decoration: const InputDecoration(
                          labelText: 'Any Other not on list?',
                          labelStyle: TextStyle(fontSize: 16),
                          hintText: 'Enter Name of Disability...',
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ))),
          ),
          GlowingActionButton(
            color: Colors.teal,
            icon: CupertinoIcons.add,
            onPressed: () {
              if (dis.text != "Any Other not on list?" &&
                  !presetDisabilities.contains(dis.text)) {
                setState(() {
                  presetDisabilities.add(dis.text);
                  dis.clear();
                });
              }
            },
          )
        ]),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 54,
              leading: Align(
                alignment: Alignment.centerRight,
                child: IconBackground(
                  icon: CupertinoIcons.back,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            body: SizedBox(
                child: Column(children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        'Medical History',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: Color(0xFF2190E5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Expanded(
                          child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Text(
                                'Please enter your Medical History details below:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w800),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                    child: Text(
                      'Do you smoke?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.yes,
                      groupValue: _smokes,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _smokes = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.no,
                      groupValue: _smokes,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _smokes = value;
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                    child: Text(
                      'Do you drink?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.yes,
                      groupValue: _drinks,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _drinks = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.no,
                      groupValue: _drinks,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _drinks = value;
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                    child: Text(
                      'Do you take any medication?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.yes,
                      groupValue: _medications,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          userHistory.medication = true;
                          setState(() {
                            _disabled = false;
                          });
                          _medications = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.no,
                      groupValue: _medications,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          userHistory.medications.clear();
                          medications.clear();
                          userHistory.medication = false;
                          setState(() {
                            _disabled = true;
                          });
                          _medications = value;
                        });
                      },
                    ),
                  ),
                  meds(),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                    child: Text(
                      'Do you have any Illnesses?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  illnesses(),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                    child: Text(
                      'Do you have any Disabilities?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  disabilities(),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                  ),
                ]),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SubmitButton(
                    color: Colors.teal,
                    message: "Submit",
                    width: 250,
                    height: 50,
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const HomePage()));
                    }),
              )
            ]))));
  }
}
