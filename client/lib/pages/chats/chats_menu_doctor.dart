import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../utilities/imports.dart';

class ChatMenuDoctor extends StatefulWidget {
  const ChatMenuDoctor({Key? key}) : super(key: key);

  @override
  State<ChatMenuDoctor> createState() => _ChatMenuDoctor();
}

class _ChatMenuDoctor extends State<ChatMenuDoctor> {
  late List<Widget> _messages;
  final int pageIndex = 1;

  Future<void> getMessages() async {
    try {
      String id = "";
      await UserSecureStorage.getID().then((value) => id = value!);
      var response = await http.get(
          Uri.parse("$SERVERDOMAIN/message/menu/${int.parse(id)}"),
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
            String name;
            if(message.senderID == int.parse(id)){
              name = await getName(message.receiverID);
            }
            else{
              name = await getName(message.senderID);
            }
            _messages.add(ChatTile(messageData: message,name:name));
          }
          setState(() {});
          break;
        case 400:
          _messages.add(Center(child:Padding(
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
          actions: const <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,
            ),
            AppDropDown(),
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
        bottomNavigationBar: DoctorBottomNavigationBar(pageIndex: pageIndex));
  }
}
