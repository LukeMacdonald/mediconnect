import 'package:http/http.dart' as http;
import '../../utilities/imports.dart';


String getDayStringFrontDayInt(int day) {
  switch (day) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    default:
      return 'Error';
  }
}

int getDayIntFromDayString(String day) {
  switch (day) {
    case "Monday":
      return 1;
    case 'Tuesday':
      return 2;
    case 'Wednesday':
      return 3;

    case 'Thursday':
      return 4;

    case 'Friday':
      return 5;
    case 'Saturday':
      return 6;
    default:
      return -1;
  }
}

String createTime(String start, String end) {
  return "${start.substring(0, start.length - 3)} - ${end.substring(0, end.length - 3)}";
}

String getTime(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
}

Future<String> getName(int id) async {

  String jwt = "";
  await UserSecureStorage.getJWTToken().then((value) => jwt = value!);

  var response = await http.get(Uri.parse("${authenticationIP}get/name/$id"),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: jwt
      });
  return response.body;
}

Future<void> deleteProfile(String email) async {
  String jwt = "";
  await UserSecureStorage.getJWTToken().then((value) => jwt = value!);
  await http.delete(Uri.parse("${authenticationIP}remove/$email"), headers: {
    'Content-Type': 'application/json',
    HttpHeaders.authorizationHeader: jwt
  });
}

void navigate(Widget page, BuildContext context) {
  Navigator.push(
      context, PageTransition(type: PageTransitionType.fade, child: page));
}

Future deleteAppointment(int id) async {
  await http.delete(Uri.parse(
      "${appointmentIP}delete/appointment/$id"));
}

Future<String?> alert(String message, BuildContext context) {
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
