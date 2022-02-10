import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/chat/chats.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/chat/add/add.dart';
import 'package:chat_app/screens/chat/home/components/messageTite.dart';
import 'package:chat_app/screens/chat/indidualChat/indidualChat.dart';
import 'package:chat_app/screens/other/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/animations/animations.dart';

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
          GestureDetector(
            child: Hero(
              tag: 'chat-appBar-image',
              child: Container(
                margin: EdgeInsets.only(bottom: 10, right: 15),
                height: 35,
                width: 35,
                child: SvgPicture.asset('assets/vectors/male.svg'),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: SettingsPage(),
                  type: PageTransitionType.fromRight,
                ),
              );
            },
          ),
        ],
      ),
      extendBody: true,
      body: FadeAnimation(
        
        child: ChatScreenBody(
          _index,
          (i) {
            setState(() {
              _index = i;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: AddPerson(),
              type: PageTransitionType.fromBottom,
            ),
          );
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
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          provider.chats.length == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Nothing Here!',
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'MontserratB',
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Click + icon to add a person.',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      // child: SvgPicture.asset('assets/vectors/loon.svg'),
                      child: Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_ocrcnofw.json',
                      ),
                      height: 320,
                    ),
                  ],
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final chat = provider.chats.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => ChangeNotifierProvider.value(
                              value: provider.chats.firstWhere(
                                  (element) => element.id == chat.id),
                              builder: (context, child) {
                                final provider = Provider.of<Chat>(context);
                                return IndidualChat(provider);
                              },
                            ),
                          ),
                        );
                        //   Navigator.push(
                        //     context,
                        //     PageTransition(
                        //       child: ChangeNotifierProvider.value(
                        //         value: provider.chats.firstWhere(
                        //             (element) => element.id == chat.id),
                        //         builder: (context, child) {
                        //           final provider = Provider.of<Chat>(context);
                        //           return IndidualChat(provider);
                        //         },
                        //       ),
                        //       type: PageTransitionType.bottomToTop,
                        //     ),
                        //   );
                        // Navigator.push(
                        //   context,
                        //   CustomRoute(
                        //     ChangeNotifierProvider.value(
                        //       value: provider.chats.firstWhere(
                        //           (element) => element.id == chat.id),
                        //       builder: (context, child) {
                        //         final provider = Provider.of<Chat>(context);
                        //         return IndidualChat(provider);
                        //       },
                        //     ),
                        //     AxisDirection.left,
                        //   ),
                        // );
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
