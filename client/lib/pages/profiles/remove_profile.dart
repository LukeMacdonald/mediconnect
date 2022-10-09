import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/widgets/profile_tile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../../utilities/imports.dart';
import 'dart:async';
import 'dart:convert';


class RemoveProfile extends StatefulWidget {
  final String role;
  const RemoveProfile({Key? key, required this.role}) : super(key: key);

  @override
  _RemoveProfileState createState() => _RemoveProfileState();
}

class _RemoveProfileState extends State<RemoveProfile> {
  
  late List<User> users;

  Future getUsers() async {
      var response = await http.get(
          Uri.parse(
              "${authenticationIP}get/users/role/${widget.role}"),
          headers: {'Content-Type': 'application/json'});
      var responses = json.decode(response.body) as List;

      for (var element in responses) {
        print(element);
        User user = User();
        if(element['firstName'] != null) {
          user.setDetails(element);
          users.add(user);
          setState(() {
          });
        }
        //setState(() {});
      }
    }


  @override
  void initState() {
    users = [];
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 54,
              leading: Align(
                alignment: Alignment.centerRight,
                child: IconBackground(
                  icon: CupertinoIcons.back,
                  onTap: () {
                    if (!mounted) return;
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: const AdminHomePage()));
                  },
                ),
              ),
              title: const Text("Remove Account"),
            ),
            //_
            body: ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index){
                  return ProfileTile(user:users[index]);
                })
        ));
  }
}
