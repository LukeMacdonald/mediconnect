import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nd_telemedicine/pages/chats/new_chat.dart';
import 'package:page_transition/page_transition.dart';
import '../../pages/imports.dart';
import '../../utilities/custom_functions.dart';

class ChatMenuPatient extends StatefulWidget {
  const ChatMenuPatient({Key? key}) : super(key: key);

  @override
  State<ChatMenuPatient> createState() => _ChatMenuPatient();
}

class _ChatMenuPatient extends State<ChatMenuPatient> {
  late List<MessageData> _messages;
  late List<String> _names;
  final int pageIndex = 1;
  late List<dynamic> _doctors;


  Future<void> getMessages() async {
    String id = "";
    await UserSecureStorage.getID().then((value) => id = value!);
    var response = await http.get(
        Uri.parse("${messageIP}get/message_menu/${int.parse(id)}"),
        headers: {'Content-Type': 'application/json'});
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
      setState(() {
        _messages.add(message);
        _names.add(name);
      });
    }
  }



  @override
  void initState() {
    _messages = [];
    _names = [];
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
                  }, icon: const Icon(CupertinoIcons.plus)),
            ),
            const AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,
            ),
            const AppDropDown(),
          ],
        ),
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ChatTile(
                        messageData: _messages[index],
                        name: _names[index],
                      );
                    },
                  ))),
        ]),
        bottomNavigationBar: CustomBBottomNavigationBar(pageIndex: pageIndex));
  }
}
