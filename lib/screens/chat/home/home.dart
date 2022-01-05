import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var chats = {
  'Mehran': 'Where were you?',
  'Farhan': 'How is life?',
  'Aprameya': 'And that\'s the end of the story',
  'Linus Torvalds': 'Big fan',
  'Bill gates': 'I got dumped again',
  'Lakshya': 'What\'s up?',
  'Aalim': 'So how was the party?',
  'Ali': 'Did you ask him why',
  'Vk': 'Attack kar!',
  'Salman': 'Chakrs yikha',
  'Tabin': 'Ok',
};
var times = [
  '25m ago',
  '2h ago',
  '10h ago',
  '11h ago',
  '12h ago',
  'Wed',
  'Mon',
  'Sun',
  'Sun',
  'Sun',
  'Sat'
];
var messageTimes = [2, 44, 12, 1, 3, 0, 0, 0, 0, 0, 0];
var read = [
  false,
  false,
  false,
  false,
  false,
  true,
  true,
  true,
  true,
  true,
  true,
  true
];
var keys = chats.keys;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!
        .getIdToken()
        .then((value) => print((value))));
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
      body: ChatScreenBody(),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.call_sharp),
          Icon(Icons.camera_alt),
          Icon(Icons.home),
          Icon(Icons.people),
          Icon(Icons.search),
        ],
        color: Theme.of(context).colorScheme.secondary,
        height: 60,
        index: 2,
        backgroundColor: Theme.of(context).backgroundColor,
        buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var subtitle = chats[keys.elementAt(index)];
              var r = read.elementAt(index);
              return MessageTile(
                keys.elementAt(index),
                subtitle,
                r,
                times[index],
                messageTimes[index],
              );
            },
            itemCount: chats.length,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final title;
  final subtitle;
  final read;
  final time;
  final count;
  MessageTile(this.title, this.subtitle, this.read, this.time, this.count);

  @override
  Widget build(BuildContext context) {
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
                  if (!read)
                    Positioned(
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          count.toString(),
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
                      title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      subtitle,
                      style: read
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
                      if (read)
                        Icon(
                          Icons.check,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                          size: 15,
                        ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        time,
                        style: read
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
