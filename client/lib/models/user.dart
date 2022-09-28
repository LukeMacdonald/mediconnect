import '../security/storage_service.dart';

class User {
  late String email;
  late String password;
  late String role;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String dob;
  late String? confirmPassword;
  late int? id;
  late String accessToken;
  late  String refreshToken;

  //User(this.email, this.password, this.role);
  User();
  //User(this.email, this.password, this.role, this.confirmPassword);

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
