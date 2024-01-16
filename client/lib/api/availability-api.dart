import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/main.dart';

import '../utilities/custom_functions.dart';

class AvailabilityAPI{

  static Future getAvailability(int id) async {
    final response = await http.get(
      Uri.parse("$SERVERDOMAIN/availability/get/$id"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var responseData = json.decode(response.body);
    return responseData;
  }
  // Future deleteAvailability(int index) async {
  //   List availabilityTarget = _availability.elementAt(index).split(' ');
  //   await http.delete(Uri.parse("$SERVERDOMAIN/availability/delete"),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         HttpHeaders.authorizationHeader: "Bearer $token"
  //       },
  //       body: json.encode({
  //         'doctorId': int.parse(id),
  //         'dayOfWeek': getDayIntFromDayString(availabilityTarget[0]),
  //         'startTime': availabilityTarget[4] + ":00",
  //         'endTime': availabilityTarget[6] + ":00",
  //       }));
  // }
}