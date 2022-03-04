import 'package:chat_app/models/chat/chat.dart';
import 'package:chat_app/models/chat/message.dart';
import 'package:chat_app/models/extras/enums.dart';
import 'package:chat_app/models/inputBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final InputBarProvider inputBarProvider =
        Provider.of<InputBarProvider>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: inputBarProvider.message == null
                ? BorderRadius.circular(25)
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
            color: const Color(0xFF3D3D3D).withAlpha(120),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {},
                color: Colors.blue,
              ),
              Expanded(
                child: TextField(
                  controller: inputTextController,
                  onChanged: (e) {
                    if (e.trim().isEmpty && showSendButton) {
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
                  autofocus: false,
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
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        widget.provider.send(
                          Message(
                            DateTime.now().toString(),
                            inputTextController.text,
                            Sender.me,
                            DateTime.now(),
                            DateTime.now().toString() + widget.provider.id,
                            MessageStatus.sending,
                            inputBarProvider.message?.commonId,
                          ),
                          widget.provider.id,
                        );
                        inputBarProvider.resetReplyTo();
                        _scrollDown(spaceTakenByKeyboard);

                        inputTextController.clear();
                        setState(() {
                          showSendButton = false;
                        });
                      },
                      color: Colors.blue,
                    )
                  : IconButton(
                      icon: const Icon(Icons.mic),
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
      duration: const Duration(milliseconds: 220),
      curve: Curves.fastOutSlowIn,
    );
  }
}
