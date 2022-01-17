import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/screens/chat/indidualChat/components/customFancyTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  MessageBubble(this.message);
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<Chat>(context);
    final mq = MediaQuery.of(context);
    return GestureDetector(
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
                        message.commonId!,
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
                  if (message.sender == Sender.me)
                  GestureDetector(
                    onTap: () {
                      chatProvider.deleteMessage(
                        message.commonId!,
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
        crossAxisAlignment: message.sender != Sender.me
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            constraints: BoxConstraints(
              maxWidth: mq.size.width * .75,
            ),
            margin: EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: Text(
                      message.data!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.5,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: message.sender != Sender.me
                  ? Theme.of(context).cardColor
                  : Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft:
                    Radius.circular(message.sender != Sender.me ? 0 : 7),
                topRight: Radius.circular(10),
                bottomRight:
                    Radius.circular(message.sender != Sender.me ? 7 : 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
