import 'package:flutter/cupertino.dart';
import '../../utilities/imports.dart';
import 'package:http/http.dart' as http;

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool isTextFieldDisabled = true;
  Color button = AppColors.secondary;
  String buttonText = "Update Profile";
  String titleText = "Profile";
  User user = User();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  Future getFields() async {
    await user.transferDetails();
    setState(() {
      _firstName.text = user.firstName;
      _lastName.text = user.lastName;
      _dob.text = user.dob;
      _phoneNumber.text = user.phoneNumber;
    });
  }

  Future updateFields() async {
    try {
      UserSecureStorage.setFirstName(user.firstName);
      UserSecureStorage.setLastName(user.lastName);
      UserSecureStorage.setPhoneNumber(user.phoneNumber);
      UserSecureStorage.setDOB(user.dob);
      var response = await http.put(Uri.parse("${authenticationIP}update"),
          headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: user.accessToken
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

      switch (response.statusCode) {
        case 200:
          if (!mounted) return;
          alert("Profile Updated!", context);
          break;
        default:
          var list = json.decode(response.body).values.toList();
          throw Exception(list.join("\n\n"));
      }
    } catch (e) {
      alert(e.toString().substring(11), context);
    }
  }

  @override
  void initState() {

    getFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 54,
              leading: Align(
                alignment: Alignment.centerRight,
                child: IconBackground(
                  icon: CupertinoIcons.back,
                  onTap: () {
                    if(user.role=="patient"||user.role == "Patient") {
                      navigate(const HomePage(), context);
                    }
                    else if(user.role=="doctor"||user.role == "Doctor") {
                      navigate(const DoctorHomePage(), context);
                    }
                    else if(user.role=="superuser"||user.role == "Superuser") {
                      navigate(const AdminHomePage(), context);
                    }
                  },
                ),
              ),
              title: Text(titleText),
            ),
            //_
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView(
                    children: [
                      const Icon(
                        CupertinoIcons.person_alt_circle_fill,
                        size: 120,
                        color: AppColors.secondary,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Account Details",style: TextStyle(fontSize: 24),),
                      ),
                      TextFormField(
                        controller: TextEditingController()..text = user.email,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          controller: _firstName,
                          readOnly: isTextFieldDisabled,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          controller: _lastName,
                          readOnly: isTextFieldDisabled,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            readOnly: isTextFieldDisabled,
                            controller: _dob,
                            decoration: const InputDecoration(
                              labelText: 'DOB',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          readOnly: isTextFieldDisabled,
                          controller: _phoneNumber,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SubmitButton(
                          color: button,
                          message: buttonText,
                          width: 50,
                          height: 50,
                          onPressed: () {
                            setState(() {
                              isTextFieldDisabled = !isTextFieldDisabled;
                              if (!isTextFieldDisabled) {
                                titleText = "Update Profile";
                                buttonText = "Submit";
                                button = Colors.teal;
                              }
                              if (isTextFieldDisabled) {
                                buttonText = "Update Profile";
                                titleText = "Profile";
                                button = AppColors.secondary;
                                user.firstName = _firstName.text;
                                user.lastName = _lastName.text;
                                user.dob = _dob.text;
                                user.phoneNumber = _phoneNumber.text;
                                updateFields();
                              }
                            });
                          },
                        ),
                      ),
                      isTextFieldDisabled && user.role == "patient"
                          ? SizedBox(
                              width: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SubmitButton(
                                  color: AppColors.accent,
                                  message: "View Medical History",
                                  width: 0,
                                  height: 50,
                                  onPressed: () {
                                    navigate(ViewMedicalHistory(id: user.id!), context);
                                  },
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class ViewOtherProfile extends StatefulWidget {
  final int id;
  const ViewOtherProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewOtherProfile> createState() => _ViewOtherProfileState();
}

class _ViewOtherProfileState extends State<ViewOtherProfile> {
  User user = User();
  Future getFields() async {
    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    var response = await http
        .get(Uri.parse("${authenticationIP}get/id/${widget.id}"), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: token,
    });
    var responseData = json.decode(response.body);
    user.email = responseData['email'];
    user.firstName = responseData['firstName'];
    user.lastName = responseData['lastName'];
    user.dob = responseData['dob'];
    user.phoneNumber = responseData['phoneNumber'];
    setState(() {});
  }

  @override
  void initState() {
    getFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 54,
              leading: Align(
                alignment: Alignment.centerRight,
                child: IconBackground(
                  icon: CupertinoIcons.back,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              title: const Text("Profile"),
            ),
            //_
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView(
                    children: [
                      const Icon(
                        CupertinoIcons.person_alt_circle_fill,
                        size: 120,
                        color: AppColors.secondary,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Account Details",style: TextStyle(fontSize: 24),),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      TextFormField(
                        controller: TextEditingController()..text = user.email,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: TextEditingController()
                          ..text = user.firstName,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      TextFormField(
                        controller: TextEditingController()
                          ..text = user.lastName,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = user.dob,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'DOB',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: TextEditingController()
                            ..text = user.phoneNumber,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
