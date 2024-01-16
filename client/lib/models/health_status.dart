class HealthStatus {

  late int id;
  bool fever = false;
  bool cough= false;
  bool headache = false;
  bool vomiting= false;
  bool faint= false;
  String description = "";

  setDetails(var details){
    id = details['appointmentId'];
    fever = details['feverOrChills'];
    cough= details['coughing'];
    headache = details ['headaches'];
    faint = details ['fainting'];
    vomiting = details['vomiting'];
    description = details['description'];
  }

}