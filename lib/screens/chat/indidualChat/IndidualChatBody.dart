import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/extras/enums.dart';
import 'package:chat_app/models/inputBar.dart';
import 'package:chat_app/screens/chat/indidualChat/components/ChatStartingWidget.dart';
import 'package:chat_app/screens/chat/indidualChat/components/messageBubble.dart';
import 'package:chat_app/screens/chat/indidualChat/inputBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class IndidualChatBody extends StatelessWidget {
  final Chat provider;
  IndidualChatBody(this.provider);
  @override
  Widget build(BuildContext context) {
    return Body(provider);
  }
}

class Body extends StatefulWidget {
  final Chat provider;

  Body(this.provider);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int replyIndex = 0;

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final InputBarProvider inputBarProvider =
        Provider.of<InputBarProvider>(context);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            controller: controller,
            // shrinkWrap: true,
            itemCount: widget.provider.messages.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.provider.messages.length) {
                return ChatStartingWidget();
              }
              return ChangeNotifierProvider.value(
                value: widget.provider.messages.elementAt(index),
                builder: (context, child) {
                  return SwipeTo(
                    child: MessageBubble(index - 1),
                    onLeftSwipe: () {
                      inputBarProvider.replyToMessage(
                        widget.provider.messages.elementAt(index),
                      );
                    },
                    onRightSwipe: () {
                      inputBarProvider.replyToMessage(
                        widget.provider.messages.elementAt(index),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        if (inputBarProvider.message != null)
          Container(
            height: 60,
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.black45,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        inputBarProvider.message!.sender == Sender.me
                            ? 'You'
                            : widget.provider.title,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => inputBarProvider.resetReplyTo(),
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    inputBarProvider.message!.data!,
                  ),
                ),
              ],
            ),
          ),
        InputBar(
          provider: widget.provider,
          controller: controller,
        ),
      ],
    );
  }
}
