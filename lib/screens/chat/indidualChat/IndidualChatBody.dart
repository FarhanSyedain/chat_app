import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/screens/chat/indidualChat/components/messageBubble.dart';
import 'package:chat_app/screens/chat/indidualChat/inputBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndidualChatBody extends StatelessWidget {
  final Chat provider;
  IndidualChatBody(this.provider);
  @override
  Widget build(BuildContext context) {
    return Body(provider);
  }
}

class Body extends StatelessWidget {
  final Chat provider;
  Body(this.provider);
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              reverse: true,
              controller: controller,
              // itemCount: messages.length,
              itemCount: provider.messages.length,
              itemBuilder: (context, index) {
                // return MessageBubble(messages[index]);
                return ChangeNotifierProvider.value(
                  value: provider.messages.elementAt(index),
                  builder: (context, child) {
                    return MessageBubble();
                  },
                );
              },
            ),
          ),
        ),
        InputBar(
          provider: provider,
          controller: controller,
        ),
      ],
    );
  }
}
