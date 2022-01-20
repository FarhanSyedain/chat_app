import 'package:chat_app/models/chat/chat.dart';
import 'package:flutter/material.dart';

const double BUBBLE_RADIUS = 16;

///basic chat bubble type
///
///chat bubble [BorderRadius] can be customized using [bubbleRadius]
///chat bubble color can be customized using [color]
///chat bubble tail can be customized  using [tail]
///chat bubble display message can be changed using [text]
///[text] is the only required parameter
///message sender can be changed using [isSender]
///[sent],[delivered] and [seen] can be used to display the message state
///chat bubble [TextStyle] can be customized using [textStyle]

class BubbleNormal extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final String text;
  final bool tail;
  final MessageStatus messageStatus;
  final TextStyle textStyle;

  BubbleNormal({
    Key? key,
    required this.text,
    this.bubbleRadius = BUBBLE_RADIUS,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.messageStatus = MessageStatus.sending,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;

    if (messageStatus == MessageStatus.delivered) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 16,
        color: Color(0xFF97AD8E)
      );
    }
    if (messageStatus == MessageStatus.sent) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done,
        size: 16,
        color: Color(0xFF97AD8E),
      );
    }
    if (messageStatus == MessageStatus.sending) {
      stateTick = true;
      stateIcon = Icon(
        Icons.access_time_outlined,
        size: 16,
        color: Color(0xFF97AD8E),
      );
    }
    if (messageStatus == MessageStatus.read) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 16,
        color: Colors.green,
      );
    }
    return Row(
      children: <Widget>[
        isSender
            ? Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        Container(
          color: Colors.transparent,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bubbleRadius),
                  topRight: Radius.circular(bubbleRadius),
                  bottomLeft: Radius.circular(tail
                      ? isSender
                          ? bubbleRadius
                          : 0
                      : BUBBLE_RADIUS),
                  bottomRight: Radius.circular(
                    tail
                        ? isSender
                            ? 0
                            : bubbleRadius
                        : BUBBLE_RADIUS,
                  ),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: stateTick
                        ? EdgeInsets.fromLTRB(12, 6, 28, 6)
                        : EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Text(
                      text,
                      style: textStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  stateIcon != null && stateTick
                      ? Positioned(
                          bottom: 4,
                          right: 6,
                          child: stateIcon,
                        )
                      : SizedBox(
                          width: 1,
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
