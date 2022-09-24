import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../main.dart';
import '../styles/background_style.dart';
import '../styles/custom_styles.dart';
import '../widgets/alerts.dart';
import '../widgets/format.dart';
import '../widgets/navbar.dart';
import 'dashboard.dart';
import 'medical_history.dart';
import '../models/user.dart';

class ProfileCreation extends StatefulWidget {
  final User user;

  const ProfileCreation({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileCreation> createState() => _ProfileCreation();
}

class _ProfileCreation extends State<ProfileCreation> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late User user = widget.user;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController dateInput;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;

  late bool passwordVisibility;
  late bool passwordConfirmVisibility;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    lastNameController = TextEditingController();
    dateInput = TextEditingController();
    passwordController = TextEditingController(text:user.password);
    passwordVisibility = false;
    passwordConfirmController = TextEditingController();
    passwordConfirmVisibility = false;
  }

  Future save() async {

    await http.put(Uri.parse("${authenticationIP}update"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: user.accessToken
        },
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'role': user.role,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'phoneNumber': user.phoneNumber,
          'dob': user.dob
        }));
    user.password = "";
    if (!mounted) return;
    if (user.role == 'patient') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MedicalHistory(user: user)));
    } else if (user.role == 'doctor') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DoctorDashboard(user: user)));
    }
  }

  Widget userPassword() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                child: TextFormField(
                  controller: passwordController,
                  onChanged: (val) {
                    user.password = val;
                  },
                  validator: (val) {
                    if (val == "") {
                      return 'Password is empty';
                    }
                    return null;
                  },
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                      //hintText: 'Enter Password',
                      hintStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                      enabledBorder: CustomOutlineInputBorder.custom,
                      focusedBorder: CustomOutlineInputBorder.custom,
                      errorBorder: CustomOutlineInputBorder.custom,
                      focusedErrorBorder: CustomOutlineInputBorder.custom,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      )),
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
                )))
      ],
    );
  }

  Widget userConfirmPassword() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                child: TextFormField(
                  controller: passwordConfirmController,
                  obscureText: !passwordConfirmVisibility,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                      hintText: 'Enter Password',
                      hintStyle: CustomText.setCustom(FontWeight.w500, 14.0,Colors.grey),
                      enabledBorder: CustomOutlineInputBorder.custom,
                      focusedBorder: CustomOutlineInputBorder.custom,
                      errorBorder: CustomOutlineInputBorder.custom,
                      focusedErrorBorder: CustomOutlineInputBorder.custom,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => passwordConfirmVisibility =
                              !passwordConfirmVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordConfirmVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      )),
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
                )))
      ],
    );
  }

  Widget userGivenFirstName() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: firstNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                    hintText: 'Enter your first name...',
                    hintStyle: CustomText.setCustom(FontWeight.w500, 14.0,Colors.grey),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
                  keyboardType: TextInputType.name,
                )))
      ],
    );
  }

  Widget userGivenLastName() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: lastNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                    hintText: 'Enter your last name...',
                    hintStyle: CustomText.setCustom(FontWeight.w500, 14.0,Colors.grey),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                  ),
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
                  keyboardType: TextInputType.name,
                )))
      ],
    );
  }

  Widget userPhoneNumber() {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: TextFormField(
                      controller: phoneNumberController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Phone Number ',
                        labelStyle: CustomText.setCustom(FontWeight.w500, 14),
                        hintText: '1800160401',
                        hintStyle: CustomText.setCustom(FontWeight.w500, 14,Colors.grey),
                        enabledBorder: CustomOutlineInputBorder.custom,
                        focusedBorder: CustomOutlineInputBorder.custom,
                        errorBorder: CustomOutlineInputBorder.custom,
                        focusedErrorBorder: CustomOutlineInputBorder.custom,
                      ),
                      style: CustomText.setCustom(FontWeight.w500, 14),
                      keyboardType: TextInputType.phone,
                    )))
          ],
        ));
  }

  Widget userDOB()  {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: TextFormField(
                  controller: dateInput,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'DOB',
                    labelStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                    hintText: 'Enter your date of birth...',
                    hintStyle: CustomText.setCustom(FontWeight.w500, 14.0),
                    enabledBorder: CustomOutlineInputBorder.custom,
                    focusedBorder: CustomOutlineInputBorder.custom,
                    errorBorder: CustomOutlineInputBorder.custom,
                    focusedErrorBorder: CustomOutlineInputBorder.custom,
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // Note that backend needs this format for string to be converted!!
                      setState(() {
                        dateInput.text = formattedDate;
                        // Will be converted in backend
                      });
                      user.dob = dateInput.text;
                    }
                  },
                  style: CustomText.setCustom(FontWeight.w500, 14.0),
                )))
      ],
    );
  }

  Widget buttonCreate(Color color, String message) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
              constraints: const BoxConstraints(minWidth: 70, maxWidth: 500),
              child: ElevatedButton(
                  onPressed: () async {
                    if(firstNameController.text == ""){
                      alert("Please Enter Your First Name!",context);
                    }
                    else if(lastNameController.text == ""){
                      alert("Please Enter Your Last Name!",context);
                    }
                    else if(dateInput.text == ""){
                      alert("Please Enter Your Date of Birth!",context);
                    }
                    else if(phoneNumberController.text == ""){
                      alert("Please Enter Your Phone Number!",context);
                    }
                    else if(passwordController.text == ""){
                      alert("Please Enter Your Password!",context);
                    }
                    else if(passwordConfirmController.text == ""){
                      alert("Please Confirm Your Password!",context);
                    }
                    else if(passwordConfirmController.text != passwordController.text ){
                      alert("Passwords Did Not Match!",context);
                    }
                    else{
                      user.firstName = firstNameController.text;
                      user.lastName = lastNameController.text;
                      user.dob = dateInput.text;
                      user.phoneNumber = phoneNumberController.text;
                      user.password = passwordController.text;
                      save();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(230, 50),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: color),
                  child: Text(
                    message,
                    style:
                        CustomText.setCustom(FontWeight.w900, 16, Colors.white),
                  )))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                        navbar2(context),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Text(
                                  'Profile Creation',
                                  style: TextStyle(
                                    fontFamily: 'Overpass',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                    color: Color(0xFF2190E5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 70, 0),
                                  child: Text(
                                      'Please enter your personal details below:',
                                      style: CustomText.setCustom(FontWeight.w500, 14),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        padding(20, 0, 0, 35),
                        userGivenFirstName(),
                        userGivenLastName(),
                        userDOB(),
                        userPhoneNumber(),
                        userPassword(),
                        userConfirmPassword(),
                        padding(0, 10, 0,0),
                        buttonCreate(const Color(0xFF2190E5), "Create Profile"),
                      ])
                    )));
  }
}
