import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/chats/chat_screen.dart';
import 'package:nd_telemedicine/widgets/avatar.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/message_data.dart';
import '../../models/user.dart';
import '../../styles/theme.dart';
import '../../widgets/helpers.dart';
import '../../widgets/navbar.dart';

Faker faker = Faker();

class ChatsPage extends StatelessWidget {

  static Route route(User user) => MaterialPageRoute(
      builder: (context) => ChatsPage(
            user: user,
          ));
  const ChatsPage({Key? key, required this.user}) : super(key: key);
  final User user;

  final int pageIndex = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarItem(
            icon: CupertinoIcons.home,
            index: pageIndex,
            user: user,
          ),
          title: const Text("Messages",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: <Widget>[
            AppBarItem(
              icon: CupertinoIcons.settings_solid,
              index: 5,
              user: user,
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(_delegete),
            )
          ],
        ),
        bottomNavigationBar: CustomBBottomNavigationBar(
            pageIndex: pageIndex, user: user));
  }

  Widget _delegete(BuildContext context, int index) {
    final Faker faker = Faker();

    return _MessageTile(
        messageData:
            MessageData(1,10, 12, DateTime.now(), faker.lorem.sentence(), true),user:user);
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.messageData,required this.user}) : super(key: key);
  final MessageData messageData;
  final User user;
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
                    user: user)));
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
                padding: EdgeInsets.all(10.0),
                child: Avatar.medium(url: Helpers.randomPictureUrl()),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(faker.person.name(),
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
