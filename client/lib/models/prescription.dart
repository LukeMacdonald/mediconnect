import 'package:nd_telemedicine/models/health_status.dart';

class Prescription {
  late int id;

  late String name;

  late double dosage;

  late int repeats;

  setDetails(var details) {
    id = details['id'];
    name = details['name'];
    dosage = details['dosage'];
    repeats = details['repeats'];
  }
}
