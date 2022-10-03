import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../models/message_data.dart';
import '../pages/chats/chat_screen.dart';
import '../styles/theme.dart';
import 'avatar.dart';
import 'helpers.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

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
                name,
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
class ChatTile extends StatelessWidget {
  const ChatTile({Key? key, required this.messageData,required this.name}) : super(key: key);
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8),

            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).cardColor,),
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
      ),
    );
  }
}
class MessageOwnTile extends StatelessWidget {
  const MessageOwnTile(
      {Key? key, required this.message, required this.messageDate})
      : super(key: key);
  final String? message;
  final String? messageDate;

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
                  child: Text(message!),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  messageDate!,
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
class MessageTile extends StatelessWidget {
  const MessageTile(
      {Key? key, required this.message, required this.messageDate})
      : super(key: key);

  final String? message;
  final String? messageDate;

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
                  child: Text(message!),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  messageDate!,
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
