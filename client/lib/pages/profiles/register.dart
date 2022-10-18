import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../utilities/imports.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _changeEmail = false;
  String? email;

  changeEmailValue(String? newText) {
    setState(() {
      _changeEmail = !_changeEmail;
      email = newText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget userRole() {
    return CustomRadioButton(
      spacing: 50,
      buttonLables: const ['Doctor', 'Patient'],
      buttonValues: const ['Doctor', 'Patient'],
      radioButtonValue: (value) {
        UserSecureStorage.setRole(value as String);
      },
      enableButtonWrap: true,
      elevation: 5,
      autoWidth: true,
      enableShape: true,
      unSelectedBorderColor: AppColors.secondary,
      selectedBorderColor: Colors.lightBlue,
      unSelectedColor: AppColors.secondary,
      selectedColor: Colors.lightBlue,
      padding: 5,
    );
  }

  Future<void> validateSave() async {
    if (await UserSecureStorage.getEmail() == "" ||
        await UserSecureStorage.getEmail() == null) {
      alert("Invalid Input!\nEmail Required!", context);
    } else if (await UserSecureStorage.getPassword() == "" ||
        await UserSecureStorage.getPassword() == null) {
      alert("Invalid Input!\nPassword Required!", context);
    } else if (await UserSecureStorage.getConfirmPassword() == "" ||
        await UserSecureStorage.getConfirmPassword() == null) {
      alert("Invalid Input!\nConfirm Password Required!", context);
    } else if (await UserSecureStorage.getPassword() !=
        await UserSecureStorage.getConfirmPassword()) {
      alert("Invalid Input!\nPassword Dont Match!", context);
    } else if (await UserSecureStorage.getRole() != "Doctor" &&
        await UserSecureStorage.getRole() != "Patient") {
      alert("Invalid Input!\nRole Not Selected!", context);
    } else {
      if (await UserSecureStorage.getRole() == "Doctor") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Verification()));
      } else {
        try {
          final response =
              await http.post(Uri.parse("${authenticationIP}register"),
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({
                    'email': await UserSecureStorage.getEmail(),
                    'password': await UserSecureStorage.getPassword(),
                    'role': await UserSecureStorage.getRole(),
                    'confirmPassword':
                        await UserSecureStorage.getConfirmPassword(),
                  }));
          switch (response.statusCode) {
            case 201:
              var responseData = json.decode(response.body);
              UserSecureStorage.setID(responseData['id'].toString());
              if (!mounted) return;
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const ProfileCreation()));
              break;
            default:
              var list = json.decode(response.body).values.toList();
              throw Exception(list.join("\n\n"));
          }
        } catch (e) {
          alert(e.toString().substring(11), context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            centerTitle: false,
            backgroundColor: Theme.of(context).backgroundColor,
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
          ),
          body: SizedBox(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 10, 15),
                child: Text(
                  'Create an account below, by entering your information.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              UserEmail(changeClassValue: changeEmailValue),
              const UserGivenPassword(),
              const UserGivenConfirmPassword(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'What Are You Registering as:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              //padding(20, 0, 0, 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: userRole(),
              ),
              SubmitButton(
                  color: Colors.teal,
                  message: "Continue",
                  width: 235,
                  height: 50,
                  onPressed: () async {
                    await UserSecureStorage.setEmail(email!);
                    validateSave();
                  }),
            ]),
          ),
        ));
  }
}
