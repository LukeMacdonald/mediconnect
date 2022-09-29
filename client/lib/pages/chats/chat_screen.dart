import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../pages/imports.dart';
import 'dart:async';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final MessageData messageData;
  final String name;

  const ChatScreen(
      {Key? key,
        required this.messageData,
        required this.name})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreen();
}
class _ChatScreen extends State<ChatScreen> {

  late MessageData messageData = widget.messageData;
  late String name = widget.name;
  late TextEditingController textEditingController;
  late List<MessageData> allMessages;
  late List<Widget> items;

  Future<void> getMessages() async {
    var response = await http.get(
        Uri.parse(
            "${messageIP}get/messages/"
                "${messageData.senderID}/"
                "${messageData.receiverID}"),
        headers: {'Content-Type': 'application/json'});
    var responses = json.decode(response.body) as List;
    MessageData message;
    for (var element in responses) {
      message = MessageData(
          element['messageID'], element['senderID'],
          element['receiverID'], DateTime.parse(element['timestamp']),
          element['message'], element['viewed'] as bool);

      String id = "";
      await UserSecureStorage.getID().then((value) => id = value!);

      if (message.senderID == int.parse(id)) {
        items.add(MessageOwnTile(message: message.message, messageDate: ""));
      }
      else {
        items.add(MessageTile(message: message.message, messageDate: ""));
      }
      setState(() {});
    }
  }
  Future<void> sendMessage(String message) async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    await http.post(Uri.parse("${messageIP}post/message"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'senderID': messageData.senderID,
          'receiverID': messageData.receiverID,
          'timestamp': formattedDate,
          'message': message,
          'viewed': false,
        })
    );
  }
  Future getUnreadMessages() async {
    MessageData message;
    while (true) {
      var response = await http.get(
          Uri.parse(
              "${messageIP}get/unread/message/"
                  "${messageData.senderID}/"
                  "${messageData.receiverID}"),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var element = json.decode(response.body);
        message = MessageData(
            element['messageID'],
            element['senderID'],
            element['receiverID'],
            DateTime.parse(element['timestamp']),
            element['message'],
            element['viewed'] as bool);
        String id = "";
        await UserSecureStorage.getID().then((value) => id = value!);
        if (mounted) {
          setState(() {
            if (message.senderID == int.parse(id)) {
              items.add(
                  MessageOwnTile(message: message.message, messageDate: ""));
            } else {
              items.add(MessageTile(message: message.message, messageDate: ""));
            }
          });
        }
        if (mounted) {
          setState(() {});
        }
      }
    }

  }

  @override
  void initState() {
    allMessages = [];
    items = [];
    textEditingController = TextEditingController();
    getMessages();
    getUnreadMessages();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.of(context).pop();
              },
            ),
          ),
          title: AppBarTitle(name: name),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                    child: IconBorder(
                      icon: CupertinoIcons.person,
                      onTap: () {},
                    )))
          ]),
      //_
      body: Column(
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return items[index];
                    },
                  ))),
          SafeArea(
              bottom: true,
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, bottom: 10, top: 10),
                          child: TextFormField(
                            controller: textEditingController,
                            style: const TextStyle(fontSize: 14.0),
                            decoration: const InputDecoration(
                              hintText: "Enter Message Here",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 24, bottom: 10, top: 10),
                      child: GlowingActionButton(
                        color: AppColors.accent,
                        icon: Icons.send_rounded,
                        onPressed: () {
                          setState(() {
                            sendMessage(textEditingController.text);
                            items.add(MessageOwnTile(
                                message: textEditingController.text,
                                messageDate: ""));
                            textEditingController.clear();
                            name = name;
                          });
                        },
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
