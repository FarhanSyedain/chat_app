import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/chat/message.dart';
import 'package:chat_app/models/extras/enums.dart';
import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  @override
  _InputBarState createState() => _InputBarState();

  final Chat provider;
  final ScrollController controller;

  InputBar({
    required this.controller,
    required this.provider,
  });
}

class _InputBarState extends State<InputBar> {
  var showSendButton = false;
  final TextEditingController inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final spaceTakenByKeyboard = MediaQuery.of(context).viewInsets.bottom;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {},
                color: Colors.blue,
              ),
              Expanded(
                child: TextField(
                  controller: inputTextController,
                  onChanged: (e) {
                    if (e.trim().length == 0 && showSendButton) {
                      setState(() {
                        showSendButton = false;
                      });
                    } else if (!showSendButton) {
                      setState(() {
                        showSendButton = true;
                      });
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Message',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              showSendButton
                  ? IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        widget.provider.send(
                          Message(
                            DateTime.now().toString(),
                            inputTextController.text,
                            Sender.me,
                            DateTime.now(),
                            DateTime.now().toString() + widget.provider.id,
                            MessageStatus.sending,
                          ),
                          widget.provider.id,
                        );
                        _scrollDown(spaceTakenByKeyboard);
                        inputTextController.clear();
                        setState(() {
                          showSendButton = false;
                        });
                      },
                      color: Colors.blue,
                    )
                  : IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {},
                      color: Colors.white,
                    ),
            ],
          ),
        ),
      ],
    );
  }

  void _scrollDown(bottomInset) {
    widget.controller.animateTo(
      0,
      duration: Duration(milliseconds: 220),
      curve: Curves.fastOutSlowIn,
    );
  }
}
