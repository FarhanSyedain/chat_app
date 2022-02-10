import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/inputBar.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/chat/indidualChat/IndidualChatBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class IndidualChat extends StatelessWidget {
  final Chat provider;
  const IndidualChat(this.provider);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context, provider.name!.split(' ')[0]),
      body: ChangeNotifierProvider(
        create: (c) => InputBarProvider(),
        builder: (context, child) {
          return IndidualChatBody(provider);
        },
      ),
    );
  }

  PreferredSize appBar(context, title) {
    return buildAppBar(
      context,
      height: 65.0,
      showBackButton: false,
      titleWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            padding: const EdgeInsets.only(top: 0.0),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: 5,
          ),
          Hero(
            tag: 'chat-image',
            child: Container(
              height: 35,
              width: 35,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              clipBehavior: Clip.hardEdge,
              child: SvgPicture.asset(
                'assets/vectors/male.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Hero(
            tag: 'chat-title',
            child: Material(
              color: Colors.transparent,
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'MontserratB',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.video_call),
          padding: EdgeInsets.zero,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.call,
          ),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
