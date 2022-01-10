import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/chat/indidualChat/IndidualChatBody.dart';
import 'package:flutter/material.dart';

class IndidualChat extends StatelessWidget {
  final Chat provider;
  IndidualChat(this.provider);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context, provider.name),
      body: IndidualChatBody(provider),
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
            padding: EdgeInsets.only(top: 0.0),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            clipBehavior: Clip.hardEdge,
            child: Image.asset('assets/dummy/profilePicture.jpg'),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'MontserratB',
              fontSize: 25,
            ),
          )
        ],
      ),
      bgColor: Theme.of(context).backgroundColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.video_call),
          padding: EdgeInsets.zero,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.call,
          ),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
