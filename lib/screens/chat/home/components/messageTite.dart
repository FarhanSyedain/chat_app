import 'package:chat_app/models/chat/chat.dart';
import 'package:flutter/material.dart';
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
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      width: double.infinity,
      height: 90,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
                    child: Image.asset(
                      'assets/dummy/profilePicture.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (!chat.read)
                    Positioned(
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          chat.count.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 12),
                        ),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          // color: Theme.of(context).colorScheme.secondary,
                          color: Colors.blue,
                        ),
                      ),
                    )
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
                    Text(
                      chat.title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    if (chat.subtitle != null)
                      Text(
                        chat.subtitle!,
                        style: chat.read
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 14)
                            : Theme.of(context).textTheme.bodyText1?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                      )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (chat.time != null)
                        Text(
                          chat.time!,
                          style: chat.read
                              ? Theme.of(context).textTheme.bodyText2
                              : Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 14),
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
