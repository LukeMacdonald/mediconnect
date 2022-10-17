import '../security/storage_service.dart';

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

  Future<void> transferDetails() async {
    String initialID = (await UserSecureStorage.getID())!;
    id = int.parse(initialID);
    email = (await UserSecureStorage.getEmail())!;
    password = (await UserSecureStorage.getPassword())!;
    role = (await UserSecureStorage.getRole())!;
    firstName =  (await UserSecureStorage.getFirstName())!;
    lastName = (await  UserSecureStorage.getLastName())!;
    phoneNumber =  (await UserSecureStorage.getPhoneNumber())!;
    dob = (await UserSecureStorage.getDOB())!;
    String? token = await UserSecureStorage.getJWTToken();
    if(token !=null ){
      accessToken = token;
    }
  }
}
