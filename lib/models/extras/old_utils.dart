
import 'package:chat_app/models/extras/old_enums.dart';

int getIntForMessageStatus(MessageStatus status) {
  switch (status) {
    case MessageStatus.sending:
      return 0;
    case MessageStatus.sent:
      return 1;
    case MessageStatus.delivered:
      return 2;
    case MessageStatus.read:
      return 3;
    case MessageStatus.received:
      return 4;
  }
}

MessageStatus getMessageStatusForInt(int number) {
  switch (number) {
    case 0:
      return MessageStatus.sending;
    case 1:
      return MessageStatus.sent;
    case 2:
      return MessageStatus.delivered;
    case 3:
      return MessageStatus.read;
    default:
      return MessageStatus.received;
  }
}
