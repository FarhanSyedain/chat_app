import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:flutter/material.dart';

var chats = {
  'Mehran': 'Where were you?',
  'Farhan': 'How is life?',
  'Lakshya': 'What\'s up?',
  'Aalim': 'So how was the party?',
  'Ali': 'Did you ask him why',
};
var read = [false, false, true, true, true];
var keys = chats.keys;

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){},backgroundColor: Colors.green),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context,
          title: 'Messages',
          showBackButton: false,
          paddingTop: 0.0,
          height: 60.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ]),
      body: ChatScreenBody(),
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var subtitle = chats[keys.elementAt(index)];
            var r = read.elementAt(index);
            return MessageTile(keys.elementAt(index), subtitle, r);
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

  MessageTile(this.title, this.subtitle, this.read);

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
      height: 70,
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
                    right: -20,
                 
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      child: Text(
                        '2',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 14),
                      ),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.green),
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
          if (read)
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Wed',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      size: 15,
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
