import 'package:chat_app/models/chat/chat.dart';
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
  int _index = 2;
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
        elevation: 1.0,
        bgColor: Theme.of(context).backgroundColor,
        title: 'Messages',
        showBackButton: false,
        paddingTop: 0.0,
        paddingBottom: 10.0,
        statusBarColor: Theme.of(context).backgroundColor,
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
      body: ChatScreenBody(_index, (i) {
        setState(() {
          _index = i;
        });
      }),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.call_sharp),
          Icon(Icons.camera_alt),
          Icon(Icons.home),
          Icon(Icons.add),
          Icon(Icons.search),
        ],
        color: Theme.of(context).colorScheme.secondary,
        height: 60,
        index: _index,
        onTap: (i) {
          if (i == 2) {
            setState(() {
              _index = 2;
            });
          } else if (i == 3) {
            setState(() {
              _index = 3;
            });
          }
        },
        backgroundColor: Theme.of(context).backgroundColor,
        buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
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
    return IndexedStack(
      index: index == 2 ? 0 : 1,
      children: [
        SingleChildScrollView(
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
                height: 20,
              ),
            ],
          ),
        ),
        AddPerson(changeIndex),
      ],
    );
  }
}
