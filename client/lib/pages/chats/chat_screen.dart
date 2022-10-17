// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';
// import '../../utilities/imports.dart';
// import 'dart:async';
// import 'dart:convert';
//
// class ChatScreen extends StatefulWidget {
//   final MessageData messageData;
//   final String name;
//
//   const ChatScreen({Key? key, required this.messageData, required this.name})
//       : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreen();
// }
//
// class _ChatScreen extends State<ChatScreen> {
//   final ScrollController _scrollController = ScrollController();
//   late MessageData messageData = widget.messageData;
//   late String name = widget.name;
//   late TextEditingController textEditingController;
//   late List<MessageData> allMessages;
//   late List<Widget> items;
//   String id = "";
//   int otherID = -1;
//
//   Future<void> getMessages() async {
//     try {
//       var response = await http.get(
//           Uri.parse("${messageIP}get/messages/"
//               "${messageData.senderID}/"
//               "${messageData.receiverID}"),
//           headers: {'Content-Type': 'application/json'});
//       switch (response.statusCode) {
//
//         case 200:
//           var responses = json.decode(response.body) as List;
//           MessageData message;
//           for (var element in responses) {
//             message = MessageData(
//                 element['messageID'],
//                 element['senderID'],
//                 element['receiverID'],
//                 DateTime.parse(element['timestamp']),
//                 element['message'],
//                 element['viewed'] as bool);
//             String id = "";
//             await UserSecureStorage.getID().then((value) => id = value!);
//
//             if (message.senderID == int.parse(id)) {
//               items.add(
//                   MessageOwnTile(message: message.message, messageDate: ""));
//               otherID = message.receiverID;
//             } else {
//               items.add(MessageTile(message: message.message, messageDate: ""));
//               otherID = message.senderID;
//             }
//             _scrollController.animateTo(
//                 _scrollController.position.maxScrollExtent,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeOut);
//             setState(() {});
//           }
//           break;
//         default:
//           var list = json.decode(response.body).values.toList();
//
//           throw Exception(list.join("\n\n"));
//       }
//     } catch (e) {
//       alert(e.toString().substring(11), context);
//     }
//   }
//
//   Future<void> sendMessage(String message) async {
//     await UserSecureStorage.getID().then((value) => id = value!);
//     try {
//       var now = DateTime.now();
//       var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
//       String formattedDate = formatter.format(now);
//       if(messageData.senderID == int.parse(id)){
//         otherID = messageData.receiverID;
//       }
//       else{
//         otherID = messageData.senderID;
//       }
//       await http.post(Uri.parse("${messageIP}post/message"),
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode({
//             'senderID': id,
//             'receiverID': otherID,
//             'timestamp': formattedDate,
//             'message': message,
//             'viewed': false,
//           }));
//     } catch (e) {
//       alert(e.toString().substring(11), context);
//     }
//   }
//   Future getUnreadMessages() async {
//     MessageData message;
//     while (true) {
//       await Future.delayed(const Duration(seconds: 5));
//       try {
//         var response = await http.get(
//             Uri.parse("${messageIP}get/unread/message/"
//                 "${messageData.senderID}/"
//                 "${messageData.receiverID}"),
//             headers: {'Content-Type': 'application/json'});
//         switch (response.statusCode) {
//           case 200:
//             var element = json.decode(response.body);
//             message = MessageData(
//                 element['messageID'],
//                 element['senderID'],
//                 element['receiverID'],
//                 DateTime.parse(element['timestamp']),
//                 element['message'],
//                 element['viewed'] as bool);
//             await UserSecureStorage.getID().then((value) => id = value!);
//             if (mounted) {
//               setState(() {
//                 if (message.senderID == int.parse(id)) {
//                   items.add(MessageOwnTile(
//                       message: message.message, messageDate: ""));
//                 } else {
//                   items.add(
//                       MessageTile(message: message.message, messageDate: ""));
//                 }
//               });
//             }
//             if (mounted) {
//               setState(() {});
//             }
//             break;
//           default:
//             var list = json.decode(response.body).values.toList();
//             throw Exception(list.join("\n\n"));
//         }
//       } catch (e) {
//         //alert(e.toString().substring(11), context);
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     allMessages = [];
//     items = [];
//     textEditingController = TextEditingController();
//     getMessages();
//     getUnreadMessages();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: AppBar(
//               iconTheme: Theme.of(context).iconTheme,
//               centerTitle: false,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               leadingWidth: 54,
//               leading: Align(
//                 alignment: Alignment.centerRight,
//                 child: IconBackground(
//                   icon: CupertinoIcons.back,
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ),
//               title: AppBarTitle(name: name),
//               actions: [
//                 Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Center(
//                         child: IconBorder(
//                           icon: CupertinoIcons.person,
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 PageTransition(
//                                     type: PageTransitionType.fade,
//                                     child: ViewOtherProfile(id: otherID)));
//                           },
//                         )))
//               ]),
//           //_
//           body: Column(
//             children: [
//               Expanded(
//                   child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: ListView.builder(
//                         controller: _scrollController,
//                         itemCount: items.length,
//                         itemBuilder: (context, index) {
//                           return items[index];
//                         },
//                       ))),
//               SafeArea(
//                   bottom: true,
//                   top: false,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Card(
//                             color: Theme.of(context).cardColor,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 16, bottom: 10, top: 10),
//                               child: TextFormField(
//                                 autofocus: true,
//                                 controller: textEditingController,
//                                 style: const TextStyle(fontSize: 14.0),
//                                 decoration: const InputDecoration(
//                                   hintText: "Enter Message Here",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.only(
//                               left: 12, right: 24, bottom: 10, top: 10),
//                           child: GlowingActionButton(
//                             color: AppColors.accent,
//                             icon: Icons.send_rounded,
//                             onPressed: () {
//                               setState(() {
//                                 sendMessage(textEditingController.text);
//                                 items.add(MessageOwnTile(
//                                     message: textEditingController.text,
//                                     messageDate: ""));
//                                 textEditingController.clear();
//                                 _scrollController.animateTo(
//                                     _scrollController.position.maxScrollExtent,
//                                     duration: const Duration(milliseconds: 500),
//                                     curve: Curves.easeOut);
//                                 name = name;
//                               });
//                             },
//                           ))
//                     ],
//                   )),
//             ],
//           ),
//         ));
//   }
// }

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../utilities/imports.dart';
import 'dart:async';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final MessageData messageData;
  final String name;

  const ChatScreen({Key? key, required this.messageData, required this.name})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late MessageData messageData = widget.messageData;
  late String name = widget.name;
  late TextEditingController textEditingController;
  late List<MessageData> allMessages;
  late List<Widget> items;
  String id = "";
  int otherID = -1;

  Future<void> getMessages() async {
    try {
      var response = await http.get(
          Uri.parse("${messageIP}get/messages/"
              "${messageData.senderID}/"
              "${messageData.receiverID}"),
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
            await UserSecureStorage.getID().then((value) => id = value!);

            if (message.senderID == int.parse(id)) {
              items.add(
                  MessageOwnTile(message: message.message, messageDate: ""));
              otherID = message.receiverID;
            } else {
              items.add(MessageTile(message: message.message, messageDate: ""));
              otherID = message.senderID;
            }
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
            setState(() {});
          }
          break;
        case 204:
          print("No New Messages");
          break;
        default:
          var list = json.decode(response.body).values.toList();
          throw Exception(list.join("\n\n"));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      String formattedDate = formatter.format(now);
      await UserSecureStorage.getID().then((value) => id = value!);
      if(otherID == -1){
        if (messageData.receiverID != int.parse(id)) {
          otherID = messageData.receiverID;
        }
        else{
          otherID = messageData.senderID;

        }
      }
      await http.post(Uri.parse("${messageIP}post/message"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'senderID': int.parse(id),
            'receiverID': otherID,
            'timestamp': formattedDate,
            'message': message,
            'viewed': false,
          }));
    } catch (e) {
      alert(e.toString().substring(11), context);
    }
  }
  Future getUnreadMessages() async {
    MessageData message;
    while (true) {
      try {
        var response = await http.get(
            Uri.parse("${messageIP}get/unread/message/"
                "${messageData.senderID}/"
                "${messageData.receiverID}"),
            headers: {'Content-Type': 'application/json'});
        await Future.delayed(const Duration(seconds: 2));
        switch (response.statusCode) {
          case 200:
            var element = json.decode(response.body);
            message = MessageData(
                element['messageID'],
                element['senderID'],
                element['receiverID'],
                DateTime.parse(element['timestamp']),
                element['message'],
                element['viewed'] as bool);
            await UserSecureStorage.getID().then((value) => id = value!);
              if (message.senderID == int.parse(id)) {
                items.add(MessageOwnTile(
                    message: message.message, messageDate: ""));
              } else {
                items.add(
                    MessageTile(message: message.message, messageDate: ""));
              }
              if (!mounted) {print("mounted");return;}
              setState(() {items = items;});
            break;
          case 400:
            break;
          default:
            var list = json
                .decode(response.body)
                .values
                .toList();
            throw Exception(list.join("\n\n"));
        }
      } catch (e) {
        if (!mounted) {return;}
        setState(() {});
        //alert(e.toString().substring(11), context);
      }
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
                  onTap: () async {
                    String role = "";
                    await UserSecureStorage.getRole().then((value) => role = value!);
                    if(!mounted)return;
                    if(role == "doctor"){
                      navigate(const ChatMenuDoctor(), context);
                    }
                    else{
                      navigate(const ChatMenuPatient(), context);
                    }
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
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ViewOtherProfile(id: otherID)));
                          },
                        )))
              ]),
          //_
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        controller: _scrollController,
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
                              autofocus: true,
                              controller: textEditingController,
                              style: const TextStyle(fontSize: 16.0),
                              decoration: const InputDecoration(
                                hintText: "Enter Message Here",
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
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
                                _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut);
                                name = name;
                                getUnreadMessages();
                              });
                            },
                          ))
                    ],
                  )),
            ],
          ),
        ));
  }
}
