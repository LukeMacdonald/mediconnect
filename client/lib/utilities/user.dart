import 'package:http/http.dart' as http;

class User {
  String email;
  String password;
  String role;
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String dob = "";
  int? id;
  String token = "";

  User(this.email, this.password, this.role);

  bool emailValid(email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  Future<void> setId() async {
    var response =
        await http.get(Uri.parse("http://localhost:8080/GetUserID/$email"));
    id = int.parse(response.body);
  }

  void setNeededDetails(Map<String, dynamic> responseData) {
    email = responseData['email'];
    role = responseData['role'];
    id = responseData['id'];

    if (responseData['firstName'] != null) {
      firstName = responseData['firstName'];
    }
    if (responseData['lastName'] != null) {
      lastName = responseData['lastName'];
    }
    if (responseData['dob'] != null) {
      dob = responseData['dob'];
    }
    if (responseData['phoneNumber'] != null) {
      phoneNumber = responseData['phoneNumber'];
    }
  }
}

class UserMedicalHistory {
  bool smoke = false;
  bool drink = false;
  bool medication = false;

  List<Object?> medications = [];
  List<Object?> userDisabilities = [];
  List<Object?> userMedications = [];
  List<Object?> userIllnesses = [];
}
