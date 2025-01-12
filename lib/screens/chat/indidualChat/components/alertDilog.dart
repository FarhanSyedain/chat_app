import 'package:chat_app/models/chat/old_chat.dart';
import 'package:chat_app/models/chat/old_message.dart';
import 'package:chat_app/models/extras/old_enums.dart';
import 'package:chat_app/screens/chat/indidualChat/components/customFancyTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteMessageAlertDilog extends StatelessWidget {
  const DeleteMessageAlertDilog({
    Key? key,
    required this.chatProvider,
    required this.messageProvider,
  }) : super(key: key);

  final Chat chatProvider;
  final Message messageProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Do you really wanna delete this message',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          SizedBox(
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
            child: SizedBox(
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
  }
}
