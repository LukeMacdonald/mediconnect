import 'package:client/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "dashboard.dart";

class LinkedLabelRadio extends StatelessWidget {
  const LinkedLabelRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              }),
          Text(
            label,
          ),
        ],
      ),
    );
  }
}

class MedicalHistoryCopyWidget extends StatefulWidget {
  const MedicalHistoryCopyWidget({Key? key}) : super(key: key);

  @override
  _MedicalHistoryCopyWidgetState createState() =>
      _MedicalHistoryCopyWidgetState();
}

class _MedicalHistoryCopyWidgetState extends State<MedicalHistoryCopyWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool smoke = false;
  bool drink = false;
  bool medication = false;

  Widget checks() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
          child: Text(
            'Are you currently taking any medication?',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
        ),
        LinkedLabelRadio(
          label: 'Yes',
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          value: true,
          groupValue: medication,
          onChanged: (bool newValue) {
            setState(() {
              medication = newValue;
            });
          },
        ),
        LinkedLabelRadio(
          label: 'No',
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          value: false,
          groupValue: medication,
          onChanged: (bool newValue) {
            setState(() {
              medication = newValue;
            });
          },
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
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
                decoration: const InputDecoration(
                  hintText: 'What Medications are you taking?\n[List Here]',
                  hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
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
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
          child: Text(
            'Do you smoke?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        LinkedLabelRadio(
          label: 'Yes',
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          value: true,
          groupValue: smoke,
          onChanged: (bool newValue) {
            setState(() {
              smoke = newValue;
            });
          },
        ),
        LinkedLabelRadio(
          label: 'No',
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          value: false,
          groupValue: smoke,
          onChanged: (bool newValue) {
            setState(() {
              smoke = newValue;
            });
          },
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
          child: Text(
            'Do you drink alcohol?',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
        ),
        LinkedLabelRadio(
          label: 'Yes',
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          value: true,
          groupValue: drink,
          onChanged: (bool newValue) {
            setState(() {
              drink = newValue;
            });
          },
        ),
        LinkedLabelRadio(
          label: 'No',
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          value: false,
          groupValue: drink,
          onChanged: (bool newValue) {
            setState(() {
              drink = newValue;
            });
          },
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
          child: Text(
            'Do you have any illnesses?',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget submit() {
    return Container(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
        child: ElevatedButton(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()))
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
      runSpacing: 0,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.down,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
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
                decoration: const InputDecoration(
                  hintText: 'Any Other not on list?',
                  hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
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
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: Text(
            'Do you have any Disabilities?',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget disabilites() {
    return Wrap(
      spacing: 60,
      runSpacing: 0,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.down,
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
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
                decoration: const InputDecoration(
                  hintText: 'Any Other not on list?',
                  hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
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
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ),
      ],
    );
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
                  mainAxisSize: MainAxisSize.max,
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
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        spacing: 0,
                                        runSpacing: 0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
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
                                            .fromSTEB(20, 0, 0, 0),
                                        child: illnesses(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(20, 0, 0, 0),
                                        child: disabilites(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 70, 10, 30),
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
