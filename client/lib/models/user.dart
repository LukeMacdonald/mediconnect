class User {
  String email;
  String password;
  String role;
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String dob = "";
  String? confirmPassword;
  int? id;
  String accessToken = "";
  String refreshToken = "";

  //User(this.email, this.password, this.role);
  User(this.email, this.password, this.role, this.confirmPassword);

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

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'role': role,
        'confirmPassword': confirmPassword,
      };
  Map<String, dynamic> doctorToJson(int code) => {
        'email': email,
        'password': password,
        'role': role,
        'confirmPassword': confirmPassword,
        'code': code,
      };
}
