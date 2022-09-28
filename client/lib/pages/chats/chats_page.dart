import 'dart:convert';
import 'dart:io';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../../pages/imports.dart';
import '../../security/storage_service.dart';



Faker faker = Faker();

class ChatPage extends StatefulWidget {

  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage  extends State<ChatPage > {

  late List<MessageData> _messages;

  late List<String> _names;

  final int pageIndex = 1;

  Future <String> getName(int id) async{

    String jwt = "";
    await UserSecureStorage.getJWTToken().then((value) => jwt = value!);

    var response = await http.get(
        Uri.parse("${authenticationIP}get/name/$id"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: jwt
        });
    return response.body;

  }
  @override
  void initState() {
    _messages = [];
    _names =[];
    getMessages();
    super.initState();
  }

  Future<void> getMessages() async{
    String id = "";
    await UserSecureStorage.getID().then((value) => id = value!);
    var response = await http.get(
        Uri.parse("${messageIP}get/message_menu/${int.parse(id)}"),
        headers: {'Content-Type': 'application/json'});
    var responses = json.decode(response.body) as List;
    print(responses);
    MessageData message;
    for (var element in responses) {
      message = MessageData(element['messageID'],
          element['senderID'],element['receiverID'],
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
                    onPressed: (){},
                    icon: const Icon(CupertinoIcons.plus)
                ),
              ),
            const AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,
            ),
            const AppDropDown(),
          ],
        ),
        body: Column(
            children: [
        Expanded(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
        ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            return _MessageTile(
              messageData: _messages[index],name: _names[index],);
          },

        )
    )
    ),]
    ),
        bottomNavigationBar: CustomBBottomNavigationBar(pageIndex: pageIndex));
  }
}

class _MessageTile extends StatelessWidget {


  const _MessageTile({Key? key, required this.messageData,required this.name}) : super(key: key);
  final MessageData messageData;
  final String name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: ChatScreen(
                  messageData: messageData,
                name: name,)));
      },
      child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: Helpers.randomPictureUrl()),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(name,
                          style: const TextStyle(
                            letterSpacing: 0.2,
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                          )),
                    ),
                    SizedBox(
                        height: 20,
                        child: Text(messageData.message,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textFaded,
                            )))
                  ]))
            ]),
          )),
    );
  }
}
