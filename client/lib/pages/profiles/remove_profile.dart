import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../utilities/imports.dart';

class RemoveProfile extends StatefulWidget {
  final String role;
  const RemoveProfile({Key? key, required this.role}) : super(key: key);

  @override
  State<RemoveProfile> createState() => _RemoveProfile();
}

class _RemoveProfile extends State<RemoveProfile> {
  late List<User> users;

  Future getUsers() async {
    try {
      var response = await http.get(
          Uri.parse("${SERVERDOMAIN}/get/users/${widget.role}"),
          headers: {'Content-Type': 'application/json'});
      switch (response.statusCode) {
        case 200:
          var responses = json.decode(response.body) as List;
          for (var element in responses) {
            User user = User();
            if (element['firstName'] != null) {
              user.setDetails(element);
              users.add(user);
              setState(() {});
            }
          }
      }
    } catch (e) {
      alert(e.toString().substring(11), context);
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
                itemBuilder: (BuildContext context, int index) {
                  return ProfileTile(user: users[index]);
                })));
  }
}
