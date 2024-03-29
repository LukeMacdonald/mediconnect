import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);
  @override
  State<ProfileCreation> createState() => _ProfileCreation();
}

class _ProfileCreation extends State<ProfileCreation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future savePatient(BuildContext context) async {
    await http.put(Uri.parse("$SERVERDOMAIN/user/update"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': await UserSecureStorage.getEmail(),
          'password': await UserSecureStorage.getPassword(),
          'role': await UserSecureStorage.getRole(),
          'firstName': await UserSecureStorage.getFirstName(),
          'lastName': await UserSecureStorage.getLastName(),
          'phoneNumber': await UserSecureStorage.getPhoneNumber(),
          'dob': await UserSecureStorage.getDOB(),
        }));
    if (await UserSecureStorage.getRole() == 'patient' ||
        await UserSecureStorage.getRole() == 'Patient') {
      if (!mounted) return;
      navigate(const MedicalHistory(), context);
    } else if (await UserSecureStorage.getRole() == 'doctor' ||
        await UserSecureStorage.getRole() == 'Doctor') {
      if (!mounted) return;
      navigate(const DoctorHomePage(), context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            body: SizedBox(
              child: Column(children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 100, 0, 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          'Profile Creation',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: Color(0xFF2190E5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 70, 5),
                              child: Text(
                                'Please enter your personal details below:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const UserGivenFirstName(),
                    const UserGivenLastName(),
                    const UserDOB(),
                    const UserGivenPhoneNumber(),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: UserGivenConfirmPassword(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 80),
                      child: SubmitButton(
                        color: AppColors.secondary,
                        message: "Submit",
                        width: 100,
                        height: 50,
                        onPressed: () async {
                          if (await UserSecureStorage.getFirstName() == "" ||
                              await UserSecureStorage.getFirstName() == null) {
                            alert("Please Enter Your First Name!", context);
                          } else if (await UserSecureStorage.getLastName() ==
                                  "" ||
                              await UserSecureStorage.getLastName() == null) {
                            alert("Please Enter Your Last Name!", context);
                          } else if (await UserSecureStorage.getDOB() == "" ||
                              await UserSecureStorage.getDOB() == null) {
                            alert("Please Enter Your Date of Birth!", context);
                          } else if (await UserSecureStorage.getFirstName() ==
                                  "" ||
                              await UserSecureStorage.getPhoneNumber() ==
                                  null) {
                            alert("Please Enter Your Phone Number!", context);
                          }
                          // else if (await UserSecureStorage.getPassword() == "" || await UserSecureStorage.getPassword()== null) {
                          //   alert("Please Enter Your Password!", context);
                          // }
                          else if (await UserSecureStorage
                                      .getConfirmPassword() ==
                                  "" ||
                              await UserSecureStorage.getConfirmPassword() ==
                                  null) {
                            alert("Please Confirm Your Password!", context);
                          } else if (await UserSecureStorage
                                  .getConfirmPassword() !=
                              await UserSecureStorage.getConfirmPassword()) {
                            alert("Passwords Did Not Match!", context);
                          } else {
                            savePatient(context);
                          }
                        },
                      ),
                    ),
                  ]),
                ),
              ]),
            )));
  }
}
