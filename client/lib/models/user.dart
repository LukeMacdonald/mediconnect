class User {
  String email = "";
  String password = "";
  String role = "";
  String firstName = "";
  String lastName = "";
   String phoneNumber = "";
   String dob = "";
   String? confirmPassword = "";
   int? id;
   String accessToken = "";
   String refreshToken = "";

   User();

  void setDetails(var responseData) {
    id = responseData['id'];
    email = responseData['email'];
    firstName = responseData['firstName'];
    lastName = responseData['lastName'];
    role = responseData['role'];
  }
}
