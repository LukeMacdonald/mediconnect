import '../../utilities/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddDoctor extends StatefulWidget {

  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctor();
}

class _AddDoctor extends State<AddDoctor> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _changeEmail = false;
  bool done = true;

  String? email;

  changeEmailValue(String? newText) {
    setState(() {
      _changeEmail = !_changeEmail;
      email = newText;
    });
  }

  Future saveDoctor(String email) async {
    done = false;
    String token = "";
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    try {

      final response = await http.get(
        Uri.parse("${SERVERDOMAIN}/admin/add/doctor/verification/$email"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      switch (response.statusCode) {
        case 201:
          dynamic responseData = json.decode(response.body);
          done = false;
          sendVerificationEmail(responseData['email'], responseData['code']);
          break;
        default:
          var list = json.decode(response.body).values.toList();
          throw Exception(list.join("\n\n"));
      }
    } catch (e) {
      if(!mounted)return;
      alert(e.toString().substring(11), context);
    }
  }

  Future sendVerificationEmail(String email, int code) async {
    try {
      final response = await http.post(
          Uri.parse("${communicationIP}send/html/mail"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'code': code}));
      switch (response.statusCode) {
        case 202:
          dynamic responseData = json.decode(response.body);
          if(!mounted)return;
          done = true;
          alert(responseData['message'], context);
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
    child:Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () {
                if(done) {
                  Navigator.of(context).pop();
                }
                else{
                  alert("Request still processing", context);
                }
              },
            ),
          ),
        ),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children:const [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'Add Doctor',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary),
                  )
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 70, 20),
                    child: Text(
                        'Please enter the email of doctor that you wish to add',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          UserEmail(changeClassValue: changeEmailValue),
          Padding(
            padding: const EdgeInsets.only(top:20,bottom:35),
            child: SubmitButton(
              color: Colors.blueAccent,
              message: "Send",
              width: 225,
              height: 50,
              onPressed: ()async {
                if(email!="") {
                  saveDoctor(email!);
                } else {
                  alert("Email Not Entered!", context);
                }
                },
            ),
          )])));
  }
}
