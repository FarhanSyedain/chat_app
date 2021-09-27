import 'package:chat_app/screens/chat/indidualChat/inputBar.dart';
import 'package:flutter/material.dart';

enum MessageStatus {
  sent,
  recieved,
  read,
}

class Message {
  String? text;
  bool? isMe;
  DateTime? time;
  MessageStatus? status;
  Message(this.text, this.isMe, {this.time, this.status});
}

final messages = [
  Message(
    'Hi',
    true,
    time: DateTime.now(),
  ),
  Message(
    'Hey man, sup?',
    false,
    time: DateTime.now().add(
      Duration(minutes: 20),
    ),
  ),
  Message(
    'Where have you been for so long?',
    false,
    time: DateTime.now().add(
      Duration(minutes: 20),
    ),
    status: MessageStatus.read,
  ),
  Message('Nothing really intresting!', true,
      time: DateTime.now().add(Duration(hours: 2))),
  Message('Had been busy with exams lately!', true,
      time: DateTime.now().add(Duration(hours: 2))),
  Message('Anyway , did you hear about the new statement Torvalds made? I really love that guy', true,
      time: DateTime.now().add(Duration(hours: 2))),
  Message(
    'Yeah man! The guy is a genius',
    false,
    time: DateTime.now().add(
      Duration(days: 1),
    ),
    status: MessageStatus.recieved,
  ),
];

class IndidualChatBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return MessageBubble(messages[index]);
            },
          ),
        ),
      ),
      InputBar(),
    ]);
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  MessageBubble(this.message);
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Column(
      crossAxisAlignment:
          message.isMe! ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          constraints: BoxConstraints(
            maxWidth: mq.size.width * .75,
          ),
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
             
                fit: FlexFit.loose,
                child: Container(
                
                  color: Colors.green,
                  child: Text(
                    
                    message.text!,
                    softWrap: true,

                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.5,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              Container(
                
                alignment: Alignment.bottomCenter,
                color: Colors.green,
                child: Text(
                  message.time!.day.toString(),

                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: message.isMe! ? Theme.of(context).cardColor : Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(message.isMe! ? 0 : 7),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(message.isMe! ? 7 : 0))),
        ),
      ],
    );
  }
}
