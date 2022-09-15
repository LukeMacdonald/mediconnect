class User {
  String email;
  String password;
  String role;
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String dob = "";

  User(this.email, this.password, this.role);

  bool emailValid(email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}

class UserMedicalHistory {
  bool smoke = false;
  bool drink = false;
  bool medication = false;

  List<String> medications = [];
  List<Object?> userDisabilities = [];
  List<Object?> userMedications = [];
  List<Object?> userIllnesses = [];
}
