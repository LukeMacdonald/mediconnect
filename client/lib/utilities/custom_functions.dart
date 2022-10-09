import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/homepage/admin_home.dart';
import '../pages/homepage/doctor_home.dart';
import '../pages/homepage/home_page.dart';
import '../pages/profiles/create_profile.dart';
import '../security/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'dart:io';
import 'dart:convert';

import '../widgets/alerts.dart';

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

Future saveDoctor(String email, BuildContext context) async {
  String token = "";
  await UserSecureStorage.getJWTToken().then((value) => token = value!);

  try {
    final response = await http.get(
      Uri.parse("${authenticationIP}admin/add/doctor/verification/$email"),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    switch (response.statusCode) {
      case 201:
        dynamic responseData = json.decode(response.body);
        sendVerificationEmail(
            responseData['email'], responseData['code'], context);
        break;
      default:
        var list = json.decode(response.body).values.toList();
        throw Exception(list.join("\n\n"));
    }
  } catch (e) {
    alert(e.toString().substring(11), context);
  }
}

Future sendVerificationEmail(
    String email, int code, BuildContext context) async {
  try {
    final response = await http.post(
        Uri.parse("${communicationIP}send/html/mail"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'code': code}));
    switch (response.statusCode) {
      case 202:
        dynamic responseData = json.decode(response.body);
        alert(responseData['message'], context);
        break;
      default:
        var list = json.decode(response.body).values.toList();
        throw Exception(list.join("\n\n"));
    }
  } catch (e) {
    alert(e.toString().substring(11), context);
  }
}

Future savePatient(BuildContext context) async {
  String token = "";
  await UserSecureStorage.getJWTToken().then((value) => token = value!);

  await http.put(Uri.parse("${authenticationIP}update"),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode({
        'email': await UserSecureStorage.getEmail(),
        'password': await UserSecureStorage.getPassword(),
        'role': await UserSecureStorage.getRole(),
        'firstName': await UserSecureStorage.getFirstName(),
        'lastName': await UserSecureStorage.getLastName(),
        'phoneNumber': await UserSecureStorage.getPhoneNumber(),
        'dob': await UserSecureStorage.getDOB(),
      }));
  if (await UserSecureStorage.getRole() == 'patient' ||
      await UserSecureStorage.getRole() == 'Patient') {
    navigate(HomePage(), context);
  } else if (await UserSecureStorage.getRole() == 'doctor' ||
      await UserSecureStorage.getRole() == 'Doctor') {
    navigate(const DoctorHomePage(), context);
  }
}

void navigate(Widget page, BuildContext context) {
  Navigator.push(
      context, PageTransition(type: PageTransitionType.fade, child: page));
}

Future login(BuildContext context) async {
  var response = await http.post(Uri.parse("${authenticationIP}login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': await UserSecureStorage.getEmail(),
        'password': await UserSecureStorage.getPassword()
      }));

  var responseData = json.decode(response.body);

  if (responseData['status'] == 401) {
    alert("User does not exist", context);
  } else {
    UserSecureStorage.setJWTToken(responseData['access_token']);

    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);

    response = await http.get(
        Uri.parse(
            "${authenticationIP}get/${await UserSecureStorage.getEmail()}"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: token,
        });
    responseData = json.decode(response.body);

    await UserSecureStorage.setID(responseData['id'].toString());
    await UserSecureStorage.setRole(responseData['role']);

    if (responseData['firstName'] == null) {
      navigate(const ProfileCreation(), context);
    } else if (responseData['role'] == "patient") {
      await UserSecureStorage().setDetails(responseData);
      navigate(const HomePage(), context);
    } else if (responseData['role'] == "doctor") {
      await UserSecureStorage().setDetails(responseData);
      navigate(const DoctorHomePage(), context);
    } else if (responseData['role'] == "superuser") {
      await UserSecureStorage().setDetails(responseData);
      navigate(const AdminHomePage(), context);
    } else {
      alert("Error Logging In", context);
    }
  }
}

Future checkAppointment(int id, String date, String startTime,BuildContext context) async {
  final response = await http.get(Uri.parse(
      "${appointmentIP}search/appointment/$id/$date/$startTime"));
  var responseData = response.body;
  if (responseData == 'false') {
    alert("Successfully Booked the Appointment!!",context);
    saveAppointment(id, date, startTime,context);
  } else {
    alert(
        "An appointment has already been made for this doctor on date selected",context);
  }
}

Future saveAppointment(int doctorId, String date, String startTime,BuildContext context) async {
  var response = await http.post(Uri.parse("${appointmentIP}set/appointment"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'patient': await UserSecureStorage.getID(),
        'doctor': doctorId,
        'date': date,
        'time': startTime,
        'today': DateFormat("HH:mm:ss").format(DateTime.now()).toString()
      }));
  navigate(HomePage(), context);

}
