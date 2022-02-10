import 'package:chat_app/models/chat/message.dart';
import 'package:chat_app/models/extras/enums.dart';
import 'package:flutter/material.dart';

const double BUBBLE_RADIUS = 16;

class BubbleInterior extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final String text;
  final bool tail;
  final MessageStatus messageStatus;
  final TextStyle textStyle;
  final String date;
  final MessageReply? replyTo;

  const BubbleInterior({
    Key? key,
    required this.text,
    this.bubbleRadius = BUBBLE_RADIUS,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.replyTo,
    this.messageStatus = MessageStatus.sending,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
    required this.date,
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    Icon? stateIcon;
    if (messageStatus == MessageStatus.delivered) {
      stateIcon = const Icon(Icons.done_all, size: 16, color: Color(0xFF97AD8E));
    }
    if (messageStatus == MessageStatus.sent) {
      stateIcon = const Icon(
        Icons.done,
        size: 16,
        color: Color(0xFF97AD8E),
      );
    }
    if (messageStatus == MessageStatus.sending) {
      stateIcon = const Icon(
        Icons.access_time_outlined,
        size: 16,
        color: Color(0xFF97AD8E),
      );
    }
    if (messageStatus == MessageStatus.read) {
      stateIcon = const Icon(
        Icons.done_all,
        size: 16,
        color: Colors.green,
      );
    }
    final suffix = Row(
      children: [
        Text(
          date,
          style: isSender
              ? const TextStyle(
                  fontSize: 12,
                )
              : const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
        ),
        if (stateIcon != null) ...[
          const SizedBox(
            width: 1,
          ),
          stateIcon
        ]
      ],
    );
    return Column(
      children: [
        if (replyTo != null)
          Row(
            children: <Widget>[
              isSender
                  ? const Expanded(
                      child: SizedBox(
                        width: 5,
                      ),
                    )
                  : const SizedBox(width: 7),
              Container(
                color: Colors.transparent,
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .85),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(bubbleRadius),
                        topRight: Radius.circular(bubbleRadius),
                        bottomLeft: const Radius.circular(BUBBLE_RADIUS),
                        bottomRight: const Radius.circular(BUBBLE_RADIUS),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 12.0, bottom: 2.0),
                          child: Text('Replied'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 7, 15, 7),
                          child: Text(
                            replyTo!.data,
                            style: textStyle.copyWith(color: Colors.white70),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isSender) const SizedBox(width: 7),
            ],
          ),
        Row(
          children: <Widget>[
            isSender
                ? const Expanded(
                    child: SizedBox(
                      width: 5,
                    ),
                  )
                : Container(),
            Container(
              color: Colors.transparent,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(bubbleRadius),
                      topRight: Radius.circular(bubbleRadius),
                      bottomLeft: const Radius.circular(BUBBLE_RADIUS),
                      bottomRight: const Radius.circular(BUBBLE_RADIUS),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(12, 8, isSender ? 54 : 38, 8),
                        child: Text(
                          text,
                          style: textStyle.copyWith(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 6,
                        child: suffix,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
