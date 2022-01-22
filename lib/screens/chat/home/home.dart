import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/chat/chats.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/chat/add/add.dart';
import 'package:chat_app/screens/chat/home/components/messageTite.dart';
import 'package:chat_app/screens/chat/indidualChat/indidualChat.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final focusNode = FocusNode();

  int _index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // backgroundColor: Color(0xff15181C),
      appBar: buildAppBar(
        context,
        elevation: 1.0,
        bgColor: Theme.of(context).backgroundColor,
        height: 50.0,
        title: 'Messages',
        showBackButton: false,
        paddingTop: 0.0,
        paddingBottom: 10.0,
        titleStyle: TextStyle(
          fontFamily: 'MontserratB',
          fontSize: 35,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
            padding: EdgeInsets.only(bottom: 10),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            padding: EdgeInsets.only(bottom: 10),
          )
        ],
      ),
      extendBody: true,
      body: ChatScreenBody(
        _index,
        (i) {
          setState(() {
            _index = i;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (x) => AddPerson()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        // backgroundColor: Colors.blue,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  final int index;
  final Function changeIndex;
  ChatScreenBody(this.index, this.changeIndex);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Chats>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Color(0xff242D34),
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final chat = provider.chats.elementAt(index);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => ChangeNotifierProvider.value(
                        value: provider.chats
                            .firstWhere((element) => element.id == chat.id),
                        builder: (context, child) {
                          final provider = Provider.of<Chat>(context);
                          return IndidualChat(provider);
                        },
                      ),
                    ),
                  );
                },
                child: MessageTile(chat),
              );
            },
            // itemCount: chats.length,
            itemCount: provider.chats.length,
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
