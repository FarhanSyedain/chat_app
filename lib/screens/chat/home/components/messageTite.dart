import 'package:chat_app/models/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MessageTile extends StatelessWidget {
  MessageTile(this.chatProviderVal);

  final Chat chatProviderVal;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Chat>.value(
      value: chatProviderVal,
      builder: (context, child) {
        return MessageTileBody();
      },
    );
  }
}

class MessageTileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<Chat>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      width: double.infinity,
      height: 85,
      padding: EdgeInsets.only(left: 15, right: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Hero(
                      tag: 'chat-image',
                      child: SvgPicture.asset(
                        'assets/vectors/male.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'chat-title',
                      child: Text(
                        chat.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    if (chat.subtitle != null)
                      Text(chat.subtitle!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (chat.time != null)
                        Text(chat.time!,
                            style: !chat.read
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      // color: Colors.blue,
                                    )
                                : Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
                if (!chat.read)
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (chat.time != null)
                          ClipOval(
                            child: Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              // color: Colors.blue,
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(chat.count.toString(),
                                  style: !chat.read
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            // color:
                                            //     Theme.of(context).colorScheme.secondary,
                                            color: Colors.white,
                                          )
                                      : Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
