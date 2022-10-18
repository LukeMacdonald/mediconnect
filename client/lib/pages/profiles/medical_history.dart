import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;

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


  UserMedicalHistory userHistory = UserMedicalHistory();

  SingingCharacter? _smokes = SingingCharacter.no;
  SingingCharacter? _drinks = SingingCharacter.no;

  List<String> presetIllnesses = [
    'Cancer',
    'Diabetes',
    'Cardiac Disease',
    'Asthma',
    'Alzheimer\'s',
    'Depression',
  ];

  List<String> presetDisabilities = [
    'Hearing Impairment',
    'Vision Impairment',
    'Autism',
    'Mobility Disability ',
    'Cerebral Palsy'
  ];


  Future save() async {
    bool smokes = _smokes == SingingCharacter.yes;
    bool drink = _drinks == SingingCharacter.yes;
    String id = "";
    await UserSecureStorage.getID().then(((value) => id = value!));

    await http.post(Uri.parse("${medicationIP}set/healthinformation"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id, 'smoke': smokes, 'drink': drink}));
    if(userHistory.userIllnesses.isNotEmpty) {
    for (int i = 0; i < userHistory.userIllnesses.length; ++i) {
      await http.post(Uri.parse("${medicationIP}set/illness"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'userId': id,
            'illness': userHistory.userIllnesses[i],
          }));
    }

    }
    if(userHistory.userDisabilities.isNotEmpty) {
      for (int i = 0; i < userHistory.userDisabilities.length; ++i) {
        await http.post(Uri.parse("${medicationIP}set/disability"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'userId': id,
              'disability': userHistory.userDisabilities[i],
            }));
      }
    }
      if(!mounted)return;
      navigate(const HomePage(), context);
  }

  Widget illnesses() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomCheckBoxGroup(
                horizontal: true,
                buttonLables: presetIllnesses,
                buttonValuesList: presetIllnesses,
                checkBoxButtonValues: (values) {
                  userHistory.userIllnesses = values;
                },
                elevation: 5,
                //autoWidth: true,
                enableShape: true,
                unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
                selectedBorderColor: const Color(0xFF2190E5),
                unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
                selectedColor: const Color(0xFF2190E5),
                padding: 5,
              ),
            ),
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
                          border: InputBorder.none,
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
                color: AppColors.secondary,
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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      SizedBox(
        height: 200,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomCheckBoxGroup(
            buttonLables: presetDisabilities,
            buttonValuesList: presetDisabilities,
            checkBoxButtonValues: (values) {
              userHistory.userDisabilities = values;
            },
            enableButtonWrap: false,
            horizontal: true,
            elevation: 5,
            autoWidth: true,
            enableShape: true,
            unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
            selectedBorderColor: const Color(0xFF2190E5),
            unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
            selectedColor: const Color(0xFF2190E5),
            padding: 5,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
                          border: InputBorder.none,
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
            color: AppColors.secondary,
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
                          color: AppColors.secondary,
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
                      'Do you smoke regularly?',
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
                      'Do you drink alcohol regularly?',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal:50),
                    child: SubmitButton(
                        color: Colors.teal,
                        message: "Submit",
                        width: 250,
                        height: 50,
                        onPressed: () {
                          save();
                        }),
                  )
                ]),

              )),

            ]))));
  }
}



class UpdateMedicalHistory extends StatefulWidget {
  final int id;
  const UpdateMedicalHistory({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateMedicalHistory> createState() => _UpdateMedicalHistory();
}

class _UpdateMedicalHistory extends State<UpdateMedicalHistory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController ill = TextEditingController();
  TextEditingController med = TextEditingController();
  TextEditingController dis = TextEditingController();


  UserMedicalHistory userHistory = UserMedicalHistory();

  SingingCharacter? _smokes = SingingCharacter.no;
  SingingCharacter? _drinks = SingingCharacter.no;


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

  Future save() async {
    bool smokes = _smokes == SingingCharacter.yes;
    bool drink = _drinks == SingingCharacter.yes;
    String id = "";
    await UserSecureStorage.getID().then(((value) => id = value!));
    await http.delete(Uri.parse("${medicationIP}delete/history/${int.parse(id)}"));
    await http.post(Uri.parse("${medicationIP}set/healthinformation"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id, 'smoke': smokes, 'drink': drink}));

    if(userHistory.userIllnesses.isNotEmpty){
    for (int i = 0; i < userHistory.userIllnesses.length; ++i) {
      await http.post(Uri.parse("${medicationIP}set/illness"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'userId': id,
            'illness': userHistory.userIllnesses[i],
          }));
    }
    }
    if(userHistory.userDisabilities.isNotEmpty) {
      for (int i = 0; i < userHistory.userDisabilities.length; ++i) {
        await http.post(Uri.parse("${medicationIP}set/disability"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'userId': id,
              'disability': userHistory.userDisabilities[i],
            }));


      }
    }
    if (!mounted) return;
    navigate( ViewMedicalHistory(id: int.parse(id)), context);
  }

  Widget illnesses() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomCheckBoxGroup(
                horizontal: true,
                buttonLables: presetIllnesses,
                buttonValuesList: presetIllnesses,
                checkBoxButtonValues: (values) {
                  userHistory.userIllnesses = values;
                },
                elevation: 5,
                //autoWidth: true,
                enableShape: true,
                unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
                selectedBorderColor: const Color(0xFF2190E5),
                unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
                selectedColor: const Color(0xFF2190E5),
                padding: 5,
              ),
            ),
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
                          border: InputBorder.none,
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
                color: AppColors.secondary,
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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomCheckBoxGroup(
                buttonLables: presetDisabilities,
                buttonValuesList: presetDisabilities,
                checkBoxButtonValues: (values) {
                  userHistory.userDisabilities = values;
                },
                enableButtonWrap: false,
                horizontal: true,
                elevation: 5,
                autoWidth: true,
                enableShape: true,
                unSelectedBorderColor: const Color.fromARGB(255, 245, 245, 245),
                selectedBorderColor: const Color(0xFF2190E5),
                unSelectedColor: const Color.fromARGB(255, 245, 245, 245),
                selectedColor: const Color(0xFF2190E5),
                padding: 5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
                              border: InputBorder.none,
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
                color: AppColors.secondary,
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
            appBar: AppBar(
                iconTheme: Theme.of(context).iconTheme,
                centerTitle: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leadingWidth: 54,
                leading: Align(
                  alignment: Alignment.centerRight,
                  child: IconBackground(
                    icon: CupertinoIcons.back,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: const Text("Update Medical History"),
                ),
            body: SizedBox(
                child: Column(children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
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
                                            fontSize: 18, fontWeight: FontWeight.w500),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                            child: Text(
                              'Do you smoke regularly?',
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
                              'Do you drink alcohol regularly?',
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
                            child: SubmitButton(
                                color: Colors.teal,
                                message: "Update",
                                width: 250,
                                height: 50,
                                onPressed: () {
                                  save();
                                }),
                          )
                        ]),
                      )),

                ]))));
  }
}
