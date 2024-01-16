import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/main.dart';
import 'package:nd_telemedicine/models/health_status.dart';
import '../models/user.dart';
import '../security/storage_service.dart';

class AppointmentService {
  static Future<List<String>> generateTimeIntervals(
      String startTime, String endTime) async {
    final List<String> availableTimes = [];

    DateTime startDateTime = DateFormat('HH:mm').parse(startTime);
    DateTime endDateTime = DateFormat('HH:mm').parse(endTime);

    DateTime end = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      endDateTime.hour,
      endDateTime.minute,
    );

    DateTime currentDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      startDateTime.hour,
      startDateTime.minute,
    );

    while (currentDateTime.isBefore(end)) {
      availableTimes.add(DateFormat('HH:mm').format(currentDateTime));
      currentDateTime = currentDateTime.add(const Duration(minutes: 30));
    }

    return availableTimes;
  }

  static Future<List<String>> checkAvailability(
      int doctorID, DateTime selected) async {
    var day = selected.weekday;
    final List<String> availableTimes = [];

    String formattedDate = DateFormat('dd/MM/yyyy').format(selected);

    try {
      List<Map<String, dynamic>> availabilities =
          await _fetchAvailabilities(doctorID, day);

      for (var availability in availabilities) {
        availableTimes.addAll(await generateTimeIntervals(
            availability['startTime'], availability['endTime']));
      }

      List<Map<String, dynamic>> appointments =
          await _fetchAppointments(doctorID, formattedDate);

      List<String> existingTimes = appointments
          .map((appointment) => appointment['time'].toString())
          .toList();

      availableTimes.removeWhere((time) => existingTimes.contains(time));

      availableTimes.sort();

      return availableTimes;
    } catch (e) {
      return []; // Handle error as needed
    }
  }

  static Future<List<Map<String, dynamic>>> _fetchAvailabilities(
      int doctorID, int day) async {
    var responseAvailability = await http.get(
      Uri.parse('$SERVERDOMAIN/availability/check/$doctorID/$day'),
      headers: {'Content-Type': 'application/json'},
    );

    if (responseAvailability.statusCode == 404) {
      throw Exception('Availability not found');
    }

    return List<Map<String, dynamic>>.from(
        json.decode(responseAvailability.body));
  }

  static Future<List<Map<String, dynamic>>> _fetchAppointments(
      int doctorID, String formattedDate) async {
    var responseAppointments = await http.get(
      Uri.parse(
          '$SERVERDOMAIN/appointment/check?id=$doctorID&date=$formattedDate'),
      headers: {'Content-Type': 'application/json'},
    );

    if (responseAppointments.statusCode == 204) {
      return []; // No appointments found
    }

    return List<Map<String, dynamic>>.from(
        json.decode(responseAppointments.body));
  }

  static Future<http.Response> bookAppointment(int doctorId, DateTime date,
      String startTime, HealthStatus symptoms) async {
    User user = User();

    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    final String formatted = formatter.format(date);
    await user.transferDetails();

    var response = await http.post(Uri.parse("$SERVERDOMAIN/appointment/save"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'patient': await UserSecureStorage.getID(),
          'doctor': doctorId,
          'date': formatted,
          'time': startTime,
          'today': DateFormat("HH:mm:ss").format(DateTime.now()).toString(),
          'email': user.email
        }));

    if (response.statusCode != 200) {
      return response;
    }

    var responseData = response.body.toString();
    symptoms.id = int.parse(responseData);

    response =
        await http.post(Uri.parse("$SERVERDOMAIN/appointment/health-status"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'appointmentId': symptoms.id,
              'feverOrChills': symptoms.fever,
              'coughing': symptoms.cough,
              'fainting': symptoms.faint,
              'vomiting': symptoms.vomiting,
              'headaches': symptoms.headache,
              'description': symptoms.description
            }));

    return response;
  }

  Future saveAppointment(int doctorId, DateTime date, String startTime) async {}
}
