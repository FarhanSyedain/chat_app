import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/chat/message.dart';
import 'package:chat_app/models/extras/enums.dart';
import 'package:chat_app/screens/chat/indidualChat/components/alertDilog.dart';
import 'package:chat_app/screens/chat/indidualChat/components/messageBubbleCore.dart';
import 'package:chat_app/screens/chat/indidualChat/extras/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MessageBubble extends StatelessWidget {
  final int lastMessageIndex;
  MessageBubble(this.lastMessageIndex);
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<Chat>(context, listen: false);
    final messageProvider = Provider.of<Message>(context);
    final core = MessageBubbleCore(
      chatProvider: chatProvider,
      messageProvider: messageProvider,
      lastMessageIndex: lastMessageIndex,
    );
    return messageProvider.messageStatus == MessageStatus.read
        ? core
        : messageProvider.sender == Sender.other
            ? VisibilityDetector(
                key: Key(messageProvider.commonId.toString()),
                onVisibilityChanged: (d) {
                  if (chatProvider.messages.first.commonId !=
                      messageProvider.commonId) return;
                  messageProvider.onMessageRead(
                    chatProvider.id,
                    FirebaseAuth.instance.currentUser!.uid,
                    messageProvider.date!,
                    Provider.of<Chat>(context, listen: false),
                  );
                },
                child: core,
              )
            : core;
  }
}

class MessageBubbleCore extends StatelessWidget {
  final Chat chatProvider;
  final Message messageProvider;
  final int lastMessageIndex;

  const MessageBubbleCore({
    Key? key,
    required this.chatProvider,
    required this.messageProvider,
    required this.lastMessageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return DeleteMessageAlertDilog(
              chatProvider: chatProvider,
              messageProvider: messageProvider,
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
            padding: EdgeInsets.only(
              bottom: lastMessageIndex == -1
                  ? 0
                  : !wasSenderSame(lastMessageIndex, chatProvider)
                      ? 10
                      : 0,
              left: 15,
              right: 15,
            ),
            child: BubbleInterior(
              replyTo: messageProvider.replyToMessage(chatProvider),
              messageStatus: messageProvider.sender == Sender.me
                  ? messageProvider.messageStatus
                  : MessageStatus.received,
              text: messageProvider.data!,
              isSender: messageProvider.sender == Sender.me ? true : false,
              color: messageProvider.sender != Sender.me
                  ? Color(0xFF446063)
                  : Color(0XFF355C7D),
              textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.5,
                    color: Colors.white,
                  ),
              date: getDate(messageProvider.date!),
            ),
          ),
        ],
      ),
    );
  }
}
