import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/screens/chat/indidualChat/components/customFancyTextButton.dart';
import 'package:chat_app/screens/chat/indidualChat/components/messageBubbleCore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MessageBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<Chat>(context, listen: false);
    final messageProvider = Provider.of<Message>(context);
    var visibilityDetector = GestureDetector(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              width: 200,
              height: 300,
              child: AlertDialog(
                backgroundColor: Theme.of(context).cardColor,
                title: Text(
                  'Do you really wanna delete this message',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                actions: [
                  Container(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: CustomFancyTextButton('No'),
                    ),
                    width: 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      chatProvider.deleteMessage(
                        messageProvider.commonId!,
                        FirebaseAuth.instance.currentUser!.uid,
                        DeleteType.local,
                        chatProvider.id,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: CustomFancyTextButton(
                        'Only me',
                        color: Colors.red,
                      ),
                      width: 100,
                    ),
                  ),
                  if (messageProvider.sender == Sender.me)
                    GestureDetector(
                      onTap: () {
                        chatProvider.deleteMessage(
                          messageProvider.commonId!,
                          FirebaseAuth.instance.currentUser!.uid,
                          DeleteType.everywhere,
                          chatProvider.id,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: CustomFancyTextButton(
                          'Everyone',
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: messageProvider.sender != Sender.me
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: BubbleNormal(
              messageStatus: messageProvider.sender == Sender.me
                  ? messageProvider.messageStatus
                  : MessageStatus.received,
              text: messageProvider.data!,
              isSender: messageProvider.sender == Sender.me ? true : false,
              color: messageProvider.sender == Sender.me
                  ? Theme.of(context).cardColor
                  : Theme.of(context).colorScheme.secondary,
              textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.5,
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
    return messageProvider.messageStatus == MessageStatus.read
        ? visibilityDetector
        : messageProvider.sender == Sender.other
            ? VisibilityDetector(
                key: Key(messageProvider.commonId.toString()),
                onVisibilityChanged: (d) {
                  if (chatProvider.messages.first.commonId !=
                      messageProvider.commonId) return;
                  print('fdsaf');
                  messageProvider.onMessageRead(
                    chatProvider.id,
                    FirebaseAuth.instance.currentUser!.uid,
                    messageProvider.date!,
                    Provider.of<Chat>(context, listen: false),
                  );
                },
                child: visibilityDetector,
              )
            : visibilityDetector;
  }
}
