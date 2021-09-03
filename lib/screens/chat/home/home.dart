import 'package:chat_app/screens/auth/components/customAppbar.dart';
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

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
        bgColor: Theme.of(context).cardColor,
        title: 'Messages',
        showBackButton: false,
        paddingTop: 0.0,
        height: 60.0,
        statusBarColor: Theme.of(context).cardColor,
        
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: ChatScreenBody(),
      //Todo: Use curved bottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).cardColor,
        fixedColor: Colors.green,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add ',
          )
        ],
      ),
      // bottomNavigationBar: BottomNavi,
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var subtitle = chats[keys.elementAt(index)];
            var r = read.elementAt(index);
            return MessageTile(keys.elementAt(index), subtitle, r, times[index],
                messageTimes[index]);
          },
          itemCount: chats.length,
        ),
      ),
    ]);
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
    // return ListTile(
    //   leading: Container(
    //     child: Image.asset('assets/dummy/profilePicture.jpg'),
    //     clipBehavior: Clip.hardEdge,
    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
    //   ),
    //   title: Text(
    //     'Mehran',
    //     style: Theme.of(context).textTheme.bodyText1,
    //   ),
    //   subtitle: Text(
    //     'Where are you?',
    //     style: Theme.of(context).textTheme.bodyText2,

    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(children: [
                Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(
                    'assets/dummy/profilePicture.jpg',
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
                            ?.copyWith(fontSize: 14),
                      ),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                    ),
                  )
              ]),
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
                      height: 4,
                    ),
                    Text(subtitle,
                        style: read
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 14)
                            : Theme.of(context).textTheme.bodyText2?.copyWith(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          ),
          // !read
          //     ? Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Container(
          //             margin: EdgeInsets.only(right: 20),
          //             alignment: Alignment.center,
          //             child: Text(
          //               '2',
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .bodyText1
          //                   ?.copyWith(fontSize: 14),
          //             ),
          //             width: 20,
          //             height: 20,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(100),
          //                 color: Colors.green),
          //           ),
          //         ],
          //       ),

          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ])
        ],
      ),
    );
  }
}
