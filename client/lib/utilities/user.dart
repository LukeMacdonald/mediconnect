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

  User(this.email, this.password, this.role);

  bool emailValid(email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  Future<void> setId() async {
    var response2 =
        await http.get(Uri.parse("http://localhost:8080/GetUserID/$email"));
    id = int.parse(response2.body);
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
