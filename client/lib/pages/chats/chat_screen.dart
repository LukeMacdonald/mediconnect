import 'dart:async';
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nd_telemedicine/main.dart';
import 'package:nd_telemedicine/models/message_data.dart';
import 'package:nd_telemedicine/widgets/icon_buttons.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../../styles/theme.dart';
import '../../widgets/avatar.dart';
import '../../widgets/buttons.dart';
import '../../widgets/helpers.dart';

Faker faker = Faker();
class ChatScreen extends StatefulWidget {
  final MessageData messageData;
  final User user;

  const ChatScreen({Key? key, required this.messageData,required this.user}) : super(key: key);

  // static Route route (MessageData data) => MaterialPageRoute(
  //     builder: (context) => ChatScreen(
  //       messageData: data,
  //       user: user,
  //     ));

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  late List<MessageData>allMessages;
  late User user = widget.user;

  late MessageData messageData = widget.messageData;
  late StreamController<MessageData> _messages;

  @override
  void initState() {
    allMessages = getMessages() as List<MessageData>;
    _messages = StreamController<MessageData>();

    for (var element in allMessages) {
      _messages.add(element);
    }
    super.initState();
  }

  Future<List<MessageData>> getMessages() async{
    List<MessageData> messages;

    var response = await http.get(
        Uri.parse("$communicationIP/get/messages${messageData.senderID}/"
                  "${messageData.receiverID}"),
        headers: {'Content-Type': 'application/json'});

    messages = (json.decode(response.body) as List).map((i) =>
        MessageData.fromJson(i)).toList();
    return messages;
  }

  Stream<List<MessageData>> getUnreadMessages() async*{
    List<MessageData>messages;
    var response = await http.get(
        Uri.parse("$communicationIP/get/unread/messages${messageData.senderID}/"
            "${messageData.receiverID}"),
        headers: {'Content-Type': 'application/json'});
    var responseData = json.decode(response.body);
    messages = (json.decode(response.body) as List).map((i) =>
        MessageData.fromJson(i)).toList();
    yield messages;
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
          title: _AppBarTitle(messageData: messageData),
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
              child: StreamBuilder(
                stream: _messages.stream,
                builder: (BuildContext context, snapshot) {
                  if(messageData.senderID == widget.user.id){
                    return _MessageOwnTile(
                        message: messageData.message,
                        messageDate: messageData.timestamp.toString());
                  }
                  else{
                    return _MessageTile(
                        message: messageData.message,
                        messageDate: messageData.timestamp.toString());
                  }
                }
                )
          ),
          const _ActionBar(),
        ],
      ),
    );
  }
}

class _DateLable extends StatefulWidget {
  const _DateLable({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  __DateLableState createState() => __DateLableState();
}

class __DateLableState extends State<_DateLable> {
  late String dayInfo;

  @override
  void initState() {
    final createdAt = Jiffy(widget.dateTime);
    final now = DateTime.now();

    if (Jiffy(createdAt).isSame(now, Units.DAY)) {
      dayInfo = 'TODAY';
    } else if (Jiffy(createdAt)
        .isSame(now.subtract(const Duration(days: 1)), Units.DAY)) {
      dayInfo = 'YESTERDAY';
    } else if (Jiffy(createdAt).isAfter(
      now.subtract(const Duration(days: 7)),
      Units.DAY,
    )) {
      dayInfo = createdAt.EEEE;
    } else if (Jiffy(createdAt).isAfter(
      Jiffy(now).subtract(years: 1),
      Units.DAY,
    )) {
      dayInfo = createdAt.MMMd;
    } else {
      dayInfo = createdAt.MMMd;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              dayInfo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
    required MessageData messageData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(
          url: Helpers.randomPictureUrl(),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr ${faker.person.lastName()}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
            ],
          ),
        )
      ],
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          _DateLable(dateTime: DateTime.now()),
          _MessageTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageOwnTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageOwnTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageOwnTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageOwnTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageOwnTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageOwnTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
          _MessageTile(
              message: faker.lorem.sentence(),
              messageDate:
                  faker.date.dateTime(minYear: 2022, maxYear: 2022).toString()),
        ],
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile(
      {Key? key, required this.message, required this.messageDate})
      : super(key: key);
  final String message;
  final String messageDate;

  static const _borderRadius = 20.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, top: 5, bottom: 5),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: Text(message),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  messageDate,
                  style: const TextStyle(
                    color: AppColors.textFaded,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile(
      {Key? key, required this.message, required this.messageDate})
      : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 15.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, top: 5, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(_borderRadius),
                      topRight: Radius.circular(_borderRadius),
                      bottomRight: Radius.circular(_borderRadius),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 20),
                  child: Text(message),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  messageDate,
                  style: const TextStyle(
                    color: AppColors.textFaded,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return SafeArea(

        bottom:true,
        top: false,
        child: Row(

          children: [
             Expanded(
               child:Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: Card(
                   color: Theme.of(context).cardColor,
                   child: const Padding(
                     padding: EdgeInsets.only(left:16,bottom: 10,top: 10),
                     child: TextField(
                       style:TextStyle(fontSize: 14.0),
                       decoration: InputDecoration(
                         hintText:"Enter Message Here",
                         border: InputBorder.none,
                       ),
                  ),
              ),
              ),
               ),
            ),
            Padding(
                padding: const EdgeInsets.only(left:12,right:24,bottom: 10,top: 10),
              child: GlowingActionButton(
                color: AppColors.accent,
                icon: Icons.send_rounded,
                onPressed: (){},
              )
            )

          ],
        ));
  }
}
