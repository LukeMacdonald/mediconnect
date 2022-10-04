import 'dart:io';

import '../../utilities/custom_functions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/imports.dart';
import 'dart:convert';

class SetAvailability extends StatefulWidget {
  const SetAvailability({Key? key,}) : super(key: key);

  @override
  State<SetAvailability> createState() => _SetAvailability();
}

class _SetAvailability extends State<SetAvailability> {

  Future save() async {

    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);


    int day = getDayIntFromDayString(dayValue);
    String id = "";
    await UserSecureStorage.getID().then((value) => id = value!);
    await http.post(Uri.parse("${availabilityIP}doctor/set/availability"),
        headers: {'Content-Type': 'application/json',
       HttpHeaders.authorizationHeader: "Bearer $token"},
        body: json.encode({
          'doctor_id': int.parse(id),
          'day_of_week': day,
          'start_time': hourValue.substring(0, 5),
          'end_time': hourValue.substring(8,)
        }));
  }

  late List<String> _availability;
  @override
  void initState() {
    _availability = [];
    getAvailability();
    super.initState();
  }

  Future getAvailability() async {
    String id = "";
    await UserSecureStorage.getID().then((value) => id = value!);
    final response =
        await http.get(Uri.parse("${availabilityIP}get/availabilities/${int.parse(id)}"));
    var responseData = json.decode(response.body);
    String day = "";
    if(responseData!=""|| responseData!=null){
    for (var availability in responseData) {
      day = getDayStringFrontDayInt(availability["day_of_week"]);
// Provided the doctor has gone through the dashboard, we simply take the doctor_id from their current availabilities
      String time = availability["_start_time"]
          .substring(0, availability["_start_time"].length) +
          " - " +
          availability["_end_time"]
              .substring(0, availability["_end_time"].length);
      _availability.add("$day  |  $time");
      setState(() {});
    }
    }
  }

  String dayValue = 'Day';
  String hourValue = 'Hour';
  final _days = [
    'Day',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
// Change the type if necessary
  final _hours = [
    'Hour',
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00 - 14:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:00 - 17:00'
  ];

  Future<String?> alert(String message) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text(message), actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ]));
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final int pageIndex = 8;

  Widget availabilityList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
              constraints: const BoxConstraints(
                  minWidth: 800, maxWidth: 800, minHeight: 300, maxHeight: 300),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
// LISTVIEW
              child: SizedBox(height: 200, child: _createListView()))
        ]);
  }

  Widget setting() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[const SizedBox(height: 10), Container()]);
  }

  Widget availability() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
          const Align(
            alignment: AlignmentDirectional(-1, 0.05),
            child: Text(
              'Availability List',
              style: TextStyle(fontSize: 20),
            ),
          ),
          availabilityList(),
          const Align(
              alignment: AlignmentDirectional(-1, 0.05),
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                  child: Text(
                    'Specific Dates Not Available',
                    style: TextStyle(fontSize: 20),
                  ))),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),

                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 100, maxWidth: 250),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 2))
                                  ]),
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 15),
                                  ),
// Initial Value
                                  value: dayValue,

// Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

// Array list of items
                                  items: _days.map((String days) {
                                    return DropdownMenuItem(
                                      value: days,
                                      child: Text(days),
                                    );
                                  }).toList(),
// After selecting the desired option,it will
// change button value to selected value
                                  onChanged: (value) {
                                    dayValue = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 250),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 1))
                                ]),
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 10),
                                ),
// Initial Value
                                value: hourValue,

// Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

// Array list of items
                                items: _hours.map((String hours) {
                                  return DropdownMenuItem(
                                    value: hours,
                                    child: Text(hours),
                                  );
                                }).toList(),
// After selecting the desired option,it will
// change button value to selected value
                                onChanged: (value) {
                                  hourValue = value.toString();
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(00, 15, 0, 10),
                            child: GlowingActionButton(
                              color: AppColors.secondary,
                              icon: CupertinoIcons.add,
                              onPressed: () {
                                if (dayValue == 'Day') {
                                  {
                                    alert('Please Enter A Day');
                                  }
                                } else if (hourValue == 'Hour') {
                                  {
                                    alert('Please Enter A Time');
                                  }
                                } else {
                                  {
                                    if (_availability
                                        .contains('$dayValue  -  $hourValue')) {
                                      alert('Availability Already Set');
                                    } else {
                                      setState(() {
                                        _availability
                                            .add('$dayValue  -  $hourValue');
                                        save();
                                      });
                                    }
                                  }
                                }
                              },),
    //
    ),
                      ],
                    )
                  ],
                )),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const AppBarItem(
            icon: CupertinoIcons.home,
            index: 0,
          ),
          title: const Text("Set Availability",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: const <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,
            ),
            SizedBox(width: 20),
            AppBarItem(
              icon: CupertinoIcons.settings_solid,
              index: 5,

            ),
            SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 700, minHeight: 580),
                  decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                  child: availability()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SubmitButton(
                color: Colors.teal,
                message: "Done",
                width: 225,
                height: 50,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )),
    );
  }
  Widget _createListView() {
    return ListView.builder(
        itemCount: _availability.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.accent,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(_availability[index]),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () {
                  SnackBar snackBar = SnackBar(
                    content:
                        Text("Availability Removed :  ${_availability[index]}"),
                    backgroundColor: Theme.of(context).cardColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    _availability.removeAt(index);
                  });
                },
              ),
            ),
          );
        });
  }
}
