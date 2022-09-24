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
  User(this.email, this.password, this.role,this.confirmPassword);

  bool emailValid(email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
  void setNeededDetails(Map<String, dynamic> responseData) {
    print(responseData);
    email = responseData['email'];
    role = responseData['role'];
    id = responseData['id'];

    if (responseData['firstName'] != null) {
      firstName = responseData['firstName'];
    }
    if (responseData['lastName']!= null) {
      lastName = responseData['lastName'];
    }
    if (responseData['dob']!= null) {
      dob = responseData['dob'];
    }
    if (responseData['phoneNumber']!= null) {
      phoneNumber = responseData['phoneNumber'];
    }
  }
}

