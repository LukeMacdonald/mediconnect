import 'package:intl/intl.dart';
import 'package:nd_telemedicine/models/health_status.dart';

class Appointment {
  late int id;

  late int patient;

  late int doctor;

  late String date;

  late String time;

  late String today;

  late HealthStatus healthStatus;

  late String dateString;


  setDetails(var details){

    id = details['id'];
    patient = details['patient'];
    doctor = details['doctor'];
    date = details['date'];
    time = details ['time'];
    today = details['today'];
    if (details['dateString'] != null){
      dateString = details['dateString'];
    }


  }
}