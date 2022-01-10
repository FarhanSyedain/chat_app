
import 'package:chat_app/models/chat/chat.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  MessageBubble(this.message);
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Column(
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
              bottomLeft: Radius.circular(message.sender != Sender.me ? 0 : 7),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(message.sender != Sender.me ? 7 : 0),
            ),
          ),
        ),
      ],
    );
  }
}
