import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../utilities/imports.dart';
import '../homepage/notifcation_page.dart';

class ChatMenuPatient extends StatefulWidget {
  const ChatMenuPatient({Key? key}) : super(key: key);

  @override
  State<ChatMenuPatient> createState() => _ChatMenuPatient();
}

class _ChatMenuPatient extends State<ChatMenuPatient> {
  late List<Widget> _messages;

  final int pageIndex = 1;

  Future<void> getMessages() async {
    try {
      String id = "";
      await UserSecureStorage.getID().then((value) => id = value!);
      var response = await http.get(
          Uri.parse("${messageIP}get/message_menu/${int.parse(id)}"),
          headers: {'Content-Type': 'application/json'});
      switch (response.statusCode) {
        case 200:
          var responses = json.decode(response.body) as List;
          MessageData message;
          for (var element in responses) {
            message = MessageData(
                element['messageID'],
                element['senderID'],
                element['receiverID'],
                DateTime.parse(element['timestamp']),
                element['message'],
                element['viewed'] as bool);
            String name = await getName(message.receiverID);
            _messages.add(ChatTile(messageData: message, name: name));
          }
          setState(() {});
          break;
        case 400:
          _messages.add(Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(response.body),
          )));
          setState(() {});
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
    _messages = [];
    getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarItem(
            icon: CupertinoIcons.home,
            index: pageIndex,
          ),
          title: const Text("Messages",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: const NewChat()));
                  },
                  icon: const Icon(CupertinoIcons.plus_bubble_fill)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: const Notifications()));
                  },
                  icon: const Icon(CupertinoIcons.bell_fill)),
            ),
          ],
        ),
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    },
                  ))),
        ]),
        bottomNavigationBar: PatientBottomNavigationBar(pageIndex: pageIndex));
  }
}
