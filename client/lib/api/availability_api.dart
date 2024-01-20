import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/main.dart';

import '../utilities/custom_functions.dart';

class AvailabilityAPI{

  static Future<http.Response> getAvailability(int id) async {
    final response = await http.get(
      Uri.parse("$SERVERDOMAIN/availability/get?id=$id"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  static Future<http.Response> all() async {

    final response = await http.get(
      Uri.parse("$SERVERDOMAIN/availability/all"),
      headers: {
        'Content-Type': 'application/json'
      },
    );

  }

  static Future<http.Response> save(int doctorID, int day, String startTime, String endTime) async {

    var response = await http.post(Uri.parse("$SERVERDOMAIN/availability/save"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: json.encode({
          'doctorId': int.parse(id),
          'dayOfWeek': day,
          'startTime': startTime
          'endTime': endTime
        }));

    return response;

  }

  static Future<http.Response> delete(int doctorID, int dayOfWeek, String startTime, String endTime ) async {
    var response =
    await http.delete(Uri.parse("$SERVERDOMAIN/availability/delete"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'doctorId': doctorID,
          'dayOfWeek': dayOfWeek,
          'startTime': startTime,
          'endTime': endTime,
        }));
    return response;
  }
}